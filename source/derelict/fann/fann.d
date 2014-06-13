/*
* Copyright (c) 2004-2012 Derelict Developers
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
*
* * Redistributions of source code must retain the above copyright
*   notice, this list of conditions and the following disclaimer.
*
* * Redistributions in binary form must reproduce the above copyright
*   notice, this list of conditions and the following disclaimer in the
*   documentation and/or other materials provided with the distribution.
*
* * Neither the names 'Derelict', 'DerelictILUT', nor the names of its contributors
*   may be used to endorse or promote products derived from this software
*   without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
* TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
* PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
module derelict.fann.fann;

public
{
    import derelict.fann.types;
    import derelict.fann.funcs;
    import derelict.fann.wrapper;
}

private
{
    import derelict.util.loader;

    version(darwin)
        version = MacOSX;
    version(OSX)
        version = MacOSX;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    version(FANN_Fixed)
    {
        static if(Derelict_OS_Windows)
            enum libNames = "fannfixed.dll";
        else
            static assert(0, "Need to implement FANN libNames for this operating system.");
    }
    else version(FANN_Float)
    {
        static if(Derelict_OS_Windows)
            enum libNames = "fannfloat.dll";
        else
            static assert(0, "Need to implement FANN libNames for this operating system.");
    }
    else version(FANN_Double)
    {
        static if(Derelict_OS_Windows)
            enum libNames = "fanndouble.dll";
        else
            static assert(0, "Need to implement FANN libNames for this operating system.");

    }
    else
    {
        static assert(0, "Need to define FANN_Fixed, FANN_Float or FANN_Double as version identifier");
    }
}

class DerelictFANNLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
            // work-around : names in FreeImage.dll are stdcall-mangled on Windows
            // Same story as for DerelictIL...
            void myBindFunc( Func )( ref Func f, string unmangledName ) {
                version( Win64 ) enum isWin64 = true;
                else enum isWin64 = false;

                static if( Derelict_OS_Windows && !isWin64 ) {
                    import std.typecons;
                    import std.string;
                    import std.typecons;
                    import std.traits;

                    // get type-tuple of parameters
                    ParameterTypeTuple!f params;

                    size_t sizeOfParametersOnStack( A... )( A args ) {
                        size_t sum = 0;
                        foreach ( arg; args ) {
                            sum += arg.sizeof;

                            // align on 32-bit stack stack ( TODO detect 64-bits systems )
                            if ( sum % 4 != 0 )
                                sum += 4 - ( sum % 4 );
                        }
                        return sum;
                    }
                    unmangledName = format( "_%s@%s", unmangledName, sizeOfParametersOnStack( params ) );
                }
                bindFunc( cast( void** )&f, unmangledName );
            }

            version(FANN_Fixed)
            {
                myBindFunc(fann_get_decimal_point, "fann_get_decimal_point");
                myBindFunc(fann_get_multiplier, "fann_get_multiplier");
            }
            else
            {
                myBindFunc(fann_train, "fann_train");
                myBindFunc(fann_train_on_data, "fann_train_on_data");
                myBindFunc(fann_train_on_file, "fann_train_on_file");
                myBindFunc(fann_train_epoch, "fann_train_epoch");
                myBindFunc(fann_test_data, "fann_test_data");
            }

            // Of course, these 3 function HAD to be mangled differently, just because
            bindFunc(cast(void**)&fann_create_standard, "fann_create_standard");
            bindFunc(cast(void**)&fann_create_sparse, "fann_create_sparse");
            bindFunc(cast(void**)&fann_create_shortcut, "fann_create_shortcut");

            myBindFunc(fann_create_standard_array, "fann_create_standard_array");
            myBindFunc(fann_create_sparse_array, "fann_create_sparse_array");
            myBindFunc(fann_create_shortcut_array, "fann_create_shortcut_array");
            myBindFunc(fann_destroy, "fann_destroy");
            myBindFunc(fann_run, "fann_run");
            myBindFunc(fann_randomize_weights, "fann_randomize_weights");
            myBindFunc(fann_init_weights, "fann_init_weights");
            myBindFunc(fann_print_connections, "fann_print_connections");
            myBindFunc(fann_print_parameters, "fann_print_parameters");
            myBindFunc(fann_get_num_input, "fann_get_num_input");
            myBindFunc(fann_get_num_output, "fann_get_num_output");
            myBindFunc(fann_get_total_neurons, "fann_get_total_neurons");
            myBindFunc(fann_get_total_connections, "fann_get_total_connections");
            myBindFunc(fann_get_network_type, "fann_get_network_type");
            myBindFunc(fann_get_connection_rate, "fann_get_connection_rate");
            myBindFunc(fann_get_num_layers, "fann_get_num_layers");
            myBindFunc(fann_get_layer_array, "fann_get_layer_array");
            myBindFunc(fann_get_bias_array, "fann_get_bias_array");
            myBindFunc(fann_get_connection_array, "fann_get_connection_array");
            myBindFunc(fann_set_weight_array, "fann_set_weight_array");
            myBindFunc(fann_set_weight, "fann_set_weight");
            myBindFunc(fann_set_user_data, "fann_set_user_data");
            myBindFunc(fann_get_user_data, "fann_get_user_data");
            myBindFunc(fann_create_from_file, "fann_create_from_file");
            myBindFunc(fann_save, "fann_save");
            myBindFunc(fann_save_to_fixed, "fann_save_to_fixed");
            myBindFunc(fann_test, "fann_test");
            myBindFunc(fann_get_MSE, "fann_get_MSE");
            myBindFunc(fann_get_bit_fail, "fann_get_bit_fail");
            myBindFunc(fann_reset_MSE, "fann_reset_MSE");
            myBindFunc(fann_read_train_from_file, "fann_read_train_from_file");
            myBindFunc(fann_create_train_from_callback, "fann_create_train_from_callback");
            myBindFunc(fann_destroy_train, "fann_destroy_train");
            
            version(FANN_Fixed)
            {
            }
            else
            {
                myBindFunc(fann_scale_train, "fann_scale_train");
                myBindFunc(fann_descale_train, "fann_descale_train");
                myBindFunc(fann_set_input_scaling_params, "fann_set_input_scaling_params");
                myBindFunc(fann_set_output_scaling_params, "fann_set_output_scaling_params");
                myBindFunc(fann_set_scaling_params, "fann_set_scaling_params");
                myBindFunc(fann_clear_scaling_params, "fann_clear_scaling_params");
                myBindFunc(fann_scale_input, "fann_scale_input");
                myBindFunc(fann_scale_output, "fann_scale_output");
                myBindFunc(fann_descale_input, "fann_descale_input");
                myBindFunc(fann_descale_output, "fann_descale_output");
            }

            myBindFunc(fann_scale_input_train_data, "fann_scale_input_train_data");
            myBindFunc(fann_scale_output_train_data, "fann_scale_output_train_data");
            myBindFunc(fann_scale_train_data, "fann_scale_train_data");
            myBindFunc(fann_merge_train_data, "fann_merge_train_data");
            myBindFunc(fann_duplicate_train_data, "fann_duplicate_train_data");
            myBindFunc(fann_subset_train_data, "fann_subset_train_data");
            myBindFunc(fann_length_train_data, "fann_length_train_data");
            myBindFunc(fann_num_input_train_data, "fann_num_input_train_data");
            myBindFunc(fann_num_output_train_data, "fann_num_output_train_data");
            myBindFunc(fann_save_train, "fann_save_train");
            myBindFunc(fann_save_train_to_fixed, "fann_save_train_to_fixed");
            myBindFunc(fann_get_training_algorithm, "fann_get_training_algorithm");
            myBindFunc(fann_set_training_algorithm, "fann_set_training_algorithm");
            myBindFunc(fann_get_learning_rate, "fann_get_learning_rate");
            myBindFunc(fann_set_learning_rate, "fann_set_learning_rate");
            myBindFunc(fann_get_learning_momentum, "fann_get_learning_momentum");
            myBindFunc(fann_set_learning_momentum, "fann_set_learning_momentum");
            myBindFunc(fann_get_activation_function, "fann_get_activation_function");
            myBindFunc(fann_set_activation_function, "fann_set_activation_function");
            myBindFunc(fann_set_activation_function_layer, "fann_set_activation_function_layer");
            myBindFunc(fann_set_activation_function_hidden, "fann_set_activation_function_hidden");
            myBindFunc(fann_set_activation_function_output, "fann_set_activation_function_output");
            myBindFunc(fann_get_activation_steepness, "fann_get_activation_steepness");
            myBindFunc(fann_set_activation_steepness, "fann_set_activation_steepness");
            myBindFunc(fann_set_activation_steepness_layer, "fann_set_activation_steepness_layer");
            myBindFunc(fann_set_activation_steepness_hidden, "fann_set_activation_steepness_hidden");
            myBindFunc(fann_set_activation_steepness_output, "fann_set_activation_steepness_output");
            myBindFunc(fann_get_train_error_function, "fann_get_train_error_function");
            myBindFunc(fann_set_train_error_function, "fann_set_train_error_function");
            myBindFunc(fann_get_train_stop_function, "fann_get_train_stop_function");
            myBindFunc(fann_set_train_stop_function, "fann_set_train_stop_function");
            myBindFunc(fann_get_bit_fail_limit, "fann_get_bit_fail_limit");
            myBindFunc(fann_set_bit_fail_limit, "fann_set_bit_fail_limit");
            myBindFunc(fann_set_callback, "fann_set_callback");
            myBindFunc(fann_get_quickprop_decay, "fann_get_quickprop_decay");
            myBindFunc(fann_set_quickprop_decay, "fann_set_quickprop_decay");
            myBindFunc(fann_get_quickprop_mu, "fann_get_quickprop_mu");
            myBindFunc(fann_set_quickprop_mu, "fann_set_quickprop_mu");
            myBindFunc(fann_get_rprop_increase_factor, "fann_get_rprop_increase_factor");
            myBindFunc(fann_set_rprop_increase_factor, "fann_set_rprop_increase_factor");
            myBindFunc(fann_get_rprop_decrease_factor, "fann_get_rprop_decrease_factor");
            myBindFunc(fann_set_rprop_decrease_factor, "fann_set_rprop_decrease_factor");
            myBindFunc(fann_get_rprop_delta_min, "fann_get_rprop_delta_min");
            myBindFunc(fann_set_rprop_delta_min, "fann_set_rprop_delta_min");
            myBindFunc(fann_get_rprop_delta_max, "fann_get_rprop_delta_max");
            myBindFunc(fann_set_rprop_delta_max, "fann_set_rprop_delta_max");
            myBindFunc(fann_get_rprop_delta_zero, "fann_get_rprop_delta_zero");
            myBindFunc(fann_set_rprop_delta_zero, "fann_set_rprop_delta_zero");
            myBindFunc(fann_set_error_log, "fann_set_error_log");
            myBindFunc(fann_get_errno, "fann_get_errno");
            myBindFunc(fann_reset_errno, "fann_reset_errno");
            myBindFunc(fann_reset_errstr, "fann_reset_errstr");
            myBindFunc(fann_get_errstr, "fann_get_errstr");
            myBindFunc(fann_print_error, "fann_print_error");

            version(FANN_Fixed) {} 
            else
            {
                myBindFunc(fann_cascadetrain_on_data, "fann_cascadetrain_on_data");
                myBindFunc(fann_cascadetrain_on_file, "fann_cascadetrain_on_file");
            }

            myBindFunc(fann_get_cascade_output_change_fraction, "fann_get_cascade_output_change_fraction");
            myBindFunc(fann_set_cascade_output_change_fraction, "fann_set_cascade_output_change_fraction");
            myBindFunc(fann_get_cascade_output_stagnation_epochs, "fann_get_cascade_output_stagnation_epochs");
            myBindFunc(fann_set_cascade_output_stagnation_epochs, "fann_set_cascade_output_stagnation_epochs");
            myBindFunc(fann_get_cascade_candidate_change_fraction, "fann_get_cascade_candidate_change_fraction");
            myBindFunc(fann_set_cascade_candidate_change_fraction, "fann_set_cascade_candidate_change_fraction");
            myBindFunc(fann_get_cascade_candidate_stagnation_epochs, "fann_get_cascade_candidate_stagnation_epochs");
            myBindFunc(fann_set_cascade_candidate_stagnation_epochs, "fann_set_cascade_candidate_stagnation_epochs");
            myBindFunc(fann_get_cascade_weight_multiplier, "fann_get_cascade_weight_multiplier");
            myBindFunc(fann_set_cascade_weight_multiplier, "fann_set_cascade_weight_multiplier");
            myBindFunc(fann_get_cascade_candidate_limit, "fann_get_cascade_candidate_limit");
            myBindFunc(fann_set_cascade_candidate_limit, "fann_set_cascade_candidate_limit");
            myBindFunc(fann_get_cascade_max_out_epochs, "fann_get_cascade_max_out_epochs");
            myBindFunc(fann_set_cascade_max_out_epochs, "fann_set_cascade_max_out_epochs");
            myBindFunc(fann_get_cascade_max_cand_epochs, "fann_get_cascade_max_cand_epochs");
            myBindFunc(fann_set_cascade_max_cand_epochs, "fann_set_cascade_max_cand_epochs");
            myBindFunc(fann_get_cascade_num_candidates, "fann_get_cascade_num_candidates");
            myBindFunc(fann_get_cascade_activation_functions_count, "fann_get_cascade_activation_functions_count");
            myBindFunc(fann_get_cascade_activation_functions, "fann_get_cascade_activation_functions");
            myBindFunc(fann_set_cascade_activation_functions, "fann_set_cascade_activation_functions");
            myBindFunc(fann_get_cascade_activation_steepnesses_count, "fann_get_cascade_activation_steepnesses_count");
            myBindFunc(fann_get_cascade_activation_steepnesses, "fann_get_cascade_activation_steepnesses");
            myBindFunc(fann_set_cascade_activation_steepnesses, "fann_set_cascade_activation_steepnesses");
            myBindFunc(fann_get_cascade_num_candidate_groups, "fann_get_cascade_num_candidate_groups");
            myBindFunc(fann_set_cascade_num_candidate_groups, "fann_set_cascade_num_candidate_groups");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictFANNLoader DerelictFANN;

shared static this()
{
    DerelictFANN = new DerelictFANNLoader();
}
