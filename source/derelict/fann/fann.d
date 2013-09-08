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
    else version(FANN_Double)
    {
        static if(Derelict_OS_Windows)
            enum libNames = "fanndouble.dll";
        else
            static assert(0, "Need to implement FANN libNames for this operating system.");
    }
    else
    {
        static if(Derelict_OS_Windows)
            enum libNames = "fannfloat.dll.dll";
        else
            static assert(0, "Need to implement FANN libNames for this operating system.");

    }
}

class DerelictFANNLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
            version(FANN_Fixed)
            {
                bindFunc(cast(void**)&fann_get_decimal_point, "fann_get_decimal_point");
                bindFunc(cast(void**)&fann_get_multiplier, "fann_get_multiplier");
            }
            else
            {
                bindFunc(cast(void**)&fann_train, "fann_train");
                bindFunc(cast(void**)&fann_train_on_data, "fann_train_on_data");
                bindFunc(cast(void**)&fann_train_on_file, "fann_train_on_file");
                bindFunc(cast(void**)&fann_train_epoch, "fann_train_epoch");
                bindFunc(cast(void**)&fann_test_data, "fann_test_data");
            }

            bindFunc(cast(void**)&fann_create_standard, "fann_create_standard");
            bindFunc(cast(void**)&fann_create_sparse, "fann_create_sparse");
            bindFunc(cast(void**)&fann_create_shortcut, "fann_create_shortcut");
            bindFunc(cast(void**)&fann_create_standard_array, "fann_create_standard_array");
            bindFunc(cast(void**)&fann_create_sparse_array, "fann_create_sparse_array");
            bindFunc(cast(void**)&fann_create_shortcut_array, "fann_create_shortcut_array");
            bindFunc(cast(void**)&fann_destroy, "fann_destroy");
            bindFunc(cast(void**)&fann_run, "fann_run");
            bindFunc(cast(void**)&fann_randomize_weights, "fann_randomize_weights");
            bindFunc(cast(void**)&fann_init_weights, "fann_init_weights");
            bindFunc(cast(void**)&fann_print_connections, "fann_print_connections");
            bindFunc(cast(void**)&fann_print_parameters, "fann_print_parameters");
            bindFunc(cast(void**)&fann_get_num_input, "fann_get_num_input");
            bindFunc(cast(void**)&fann_get_num_output, "fann_get_num_output");
            bindFunc(cast(void**)&fann_get_total_neurons, "fann_get_total_neurons");
            bindFunc(cast(void**)&fann_get_total_connections, "fann_get_total_connections");
            bindFunc(cast(void**)&fann_get_network_type, "fann_get_network_type");
            bindFunc(cast(void**)&fann_get_connection_rate, "fann_get_connection_rate");
            bindFunc(cast(void**)&fann_get_num_layers, "fann_get_num_layers");
            bindFunc(cast(void**)&fann_get_layer_array, "fann_get_layer_array");
            bindFunc(cast(void**)&fann_get_bias_array, "fann_get_bias_array");
            bindFunc(cast(void**)&fann_get_connection_array, "fann_get_connection_array");
            bindFunc(cast(void**)&fann_set_weight_array, "fann_set_weight_array");
            bindFunc(cast(void**)&fann_set_weight, "fann_set_weight");
            bindFunc(cast(void**)&fann_set_user_data, "fann_set_user_data");
            bindFunc(cast(void**)&fann_get_user_data, "fann_get_user_data");
            bindFunc(cast(void**)&fann_create_from_file, "fann_create_from_file");
            bindFunc(cast(void**)&fann_save, "fann_save");
            bindFunc(cast(void**)&fann_save_to_fixed, "fann_save_to_fixed");
            bindFunc(cast(void**)&fann_test, "fann_test");
            bindFunc(cast(void**)&fann_get_MSE, "fann_get_MSE");
            bindFunc(cast(void**)&fann_get_bit_fail, "fann_get_bit_fail");
            bindFunc(cast(void**)&fann_reset_MSE, "fann_reset_MSE");
            bindFunc(cast(void**)&fann_read_train_from_file, "fann_read_train_from_file");
            bindFunc(cast(void**)&fann_create_train_from_callback, "fann_create_train_from_callback");
            bindFunc(cast(void**)&fann_destroy_train, "fann_destroy_train");
            bindFunc(cast(void**)&fann_shuffle_train_data, "fann_shuffle_train_data");
            bindFunc(cast(void**)&fann_scale_train, "fann_scale_train");
            bindFunc(cast(void**)&fann_descale_train, "fann_descale_train");
            bindFunc(cast(void**)&fann_set_input_scaling_params, "fann_set_input_scaling_params");
            bindFunc(cast(void**)&fann_set_output_scaling_params, "fann_set_output_scaling_params");
            bindFunc(cast(void**)&fann_set_scaling_params, "fann_set_scaling_params");
            bindFunc(cast(void**)&fann_clear_scaling_params, "fann_clear_scaling_params");
            bindFunc(cast(void**)&fann_scale_input, "fann_scale_input");
            bindFunc(cast(void**)&fann_scale_output, "fann_scale_output");
            bindFunc(cast(void**)&fann_descale_input, "fann_descale_input");
            bindFunc(cast(void**)&fann_descale_output, "fann_descale_output");
            bindFunc(cast(void**)&fann_scale_input_train_data, "fann_scale_input_train_data");
            bindFunc(cast(void**)&fann_scale_output_train_data, "fann_scale_output_train_data");
            bindFunc(cast(void**)&fann_scale_train_data, "fann_scale_train_data");
            bindFunc(cast(void**)&fann_merge_train_data, "fann_merge_train_data");
            bindFunc(cast(void**)&fann_duplicate_train_data, "fann_duplicate_train_data");
            bindFunc(cast(void**)&fann_subset_train_data, "fann_subset_train_data");
            bindFunc(cast(void**)&fann_length_train_data, "fann_length_train_data");
            bindFunc(cast(void**)&fann_num_input_train_data, "fann_num_input_train_data");
            bindFunc(cast(void**)&fann_num_output_train_data, "fann_num_output_train_data");
            bindFunc(cast(void**)&fann_save_train, "fann_save_train");
            bindFunc(cast(void**)&fann_save_train_to_fixed, "fann_save_train_to_fixed");
            bindFunc(cast(void**)&fann_get_training_algorithm, "fann_get_training_algorithm");
            bindFunc(cast(void**)&fann_set_training_algorithm, "fann_set_training_algorithm");
            bindFunc(cast(void**)&fann_get_learning_rate, "fann_get_learning_rate");
            bindFunc(cast(void**)&fann_set_learning_rate, "fann_set_learning_rate");
            bindFunc(cast(void**)&fann_get_learning_momentum, "fann_get_learning_momentum");
            bindFunc(cast(void**)&fann_set_learning_momentum, "fann_set_learning_momentum");
            bindFunc(cast(void**)&fann_get_activation_function, "fann_get_activation_function");
            bindFunc(cast(void**)&fann_set_activation_function, "fann_set_activation_function");
            bindFunc(cast(void**)&fann_set_activation_function_layer, "fann_set_activation_function_layer");
            bindFunc(cast(void**)&fann_set_activation_function_hidden, "fann_set_activation_function_hidden");
            bindFunc(cast(void**)&fann_set_activation_function_output, "fann_set_activation_function_output");
            bindFunc(cast(void**)&fann_get_activation_steepness, "fann_get_activation_steepness");
            bindFunc(cast(void**)&fann_set_activation_steepness, "fann_set_activation_steepness");
            bindFunc(cast(void**)&fann_set_activation_steepness_layer, "fann_set_activation_steepness_layer");
            bindFunc(cast(void**)&fann_set_activation_steepness_hidden, "fann_set_activation_steepness_hidden");
            bindFunc(cast(void**)&fann_set_activation_steepness_output, "fann_set_activation_steepness_output");
            bindFunc(cast(void**)&fann_get_train_error_function, "fann_get_train_error_function");
            bindFunc(cast(void**)&fann_set_train_error_function, "fann_set_train_error_function");
            bindFunc(cast(void**)&fann_get_train_stop_function, "fann_get_train_stop_function");
            bindFunc(cast(void**)&fann_set_train_stop_function, "fann_set_train_stop_function");
            bindFunc(cast(void**)&fann_get_bit_fail_limit, "fann_get_bit_fail_limit");
            bindFunc(cast(void**)&fann_set_bit_fail_limit, "fann_set_bit_fail_limit");
            bindFunc(cast(void**)&fann_set_callback, "fann_set_callback");
            bindFunc(cast(void**)&fann_get_quickprop_decay, "fann_get_quickprop_decay");
            bindFunc(cast(void**)&fann_set_quickprop_decay, "fann_set_quickprop_decay");
            bindFunc(cast(void**)&fann_get_quickprop_mu, "fann_get_quickprop_mu");
            bindFunc(cast(void**)&fann_set_quickprop_mu, "fann_set_quickprop_mu");
            bindFunc(cast(void**)&fann_get_rprop_increase_factor, "fann_get_rprop_increase_factor");
            bindFunc(cast(void**)&fann_set_rprop_increase_factor, "fann_set_rprop_increase_factor");
            bindFunc(cast(void**)&fann_get_rprop_decrease_factor, "fann_get_rprop_decrease_factor");
            bindFunc(cast(void**)&fann_set_rprop_decrease_factor, "fann_set_rprop_decrease_factor");
            bindFunc(cast(void**)&fann_get_rprop_delta_min, "fann_get_rprop_delta_min");
            bindFunc(cast(void**)&fann_set_rprop_delta_min, "fann_set_rprop_delta_min");
            bindFunc(cast(void**)&fann_get_rprop_delta_max, "fann_get_rprop_delta_max");
            bindFunc(cast(void**)&fann_set_rprop_delta_max, "fann_set_rprop_delta_max");
            bindFunc(cast(void**)&fann_get_rprop_delta_zero, "fann_get_rprop_delta_zero");
            bindFunc(cast(void**)&fann_set_rprop_delta_zero, "fann_set_rprop_delta_zero");
            bindFunc(cast(void**)&fann_set_error_log, "fann_set_error_log");
            bindFunc(cast(void**)&fann_get_errno, "fann_get_errno");
            bindFunc(cast(void**)&fann_reset_errno, "fann_reset_errno");
            bindFunc(cast(void**)&fann_reset_errstr, "fann_reset_errstr");
            bindFunc(cast(void**)&fann_get_errstr, "fann_get_errstr");
            bindFunc(cast(void**)&fann_print_error, "fann_print_error");
            bindFunc(cast(void**)&fann_cascadetrain_on_data, "fann_cascadetrain_on_data");
            bindFunc(cast(void**)&fann_cascadetrain_on_file, "fann_cascadetrain_on_file");
            bindFunc(cast(void**)&fann_get_cascade_output_change_fraction, "fann_get_cascade_output_change_fraction");
            bindFunc(cast(void**)&fann_set_cascade_output_change_fraction, "fann_set_cascade_output_change_fraction");
            bindFunc(cast(void**)&fann_get_cascade_output_stagnation_epochs, "fann_get_cascade_output_stagnation_epochs");
            bindFunc(cast(void**)&fann_set_cascade_output_stagnation_epochs, "fann_set_cascade_output_stagnation_epochs");
            bindFunc(cast(void**)&fann_get_cascade_candidate_change_fraction, "fann_get_cascade_candidate_change_fraction");
            bindFunc(cast(void**)&fann_set_cascade_candidate_change_fraction, "fann_set_cascade_candidate_change_fraction");
            bindFunc(cast(void**)&fann_get_cascade_candidate_stagnation_epochs, "fann_get_cascade_candidate_stagnation_epochs");
            bindFunc(cast(void**)&fann_set_cascade_candidate_stagnation_epochs, "fann_set_cascade_candidate_stagnation_epochs");
            bindFunc(cast(void**)&fann_get_cascade_weight_multiplier, "fann_get_cascade_weight_multiplier");
            bindFunc(cast(void**)&fann_set_cascade_weight_multiplier, "fann_set_cascade_weight_multiplier");
            bindFunc(cast(void**)&fann_get_cascade_candidate_limit, "fann_get_cascade_candidate_limit");
            bindFunc(cast(void**)&fann_set_cascade_candidate_limit, "fann_set_cascade_candidate_limit");
            bindFunc(cast(void**)&fann_get_cascade_max_out_epochs, "fann_get_cascade_max_out_epochs");
            bindFunc(cast(void**)&fann_set_cascade_max_out_epochs, "fann_set_cascade_max_out_epochs");
            bindFunc(cast(void**)&fann_get_cascade_max_cand_epochs, "fann_get_cascade_max_cand_epochs");
            bindFunc(cast(void**)&fann_set_cascade_max_cand_epochs, "fann_set_cascade_max_cand_epochs");
            bindFunc(cast(void**)&fann_get_cascade_num_candidates, "fann_get_cascade_num_candidates");
            bindFunc(cast(void**)&fann_get_cascade_activation_functions_count, "fann_get_cascade_activation_functions_count");
            bindFunc(cast(void**)&fann_get_cascade_activation_functions, "fann_get_cascade_activation_functions");
            bindFunc(cast(void**)&fann_set_cascade_activation_functions, "fann_set_cascade_activation_functions");
            bindFunc(cast(void**)&fann_get_cascade_activation_steepnesses_count, "fann_get_cascade_activation_steepnesses_count");
            bindFunc(cast(void**)&fann_get_cascade_activation_steepnesses, "fann_get_cascade_activation_steepnesses");
            bindFunc(cast(void**)&fann_set_cascade_activation_steepnesses, "fann_set_cascade_activation_steepnesses");
            bindFunc(cast(void**)&fann_get_cascade_num_candidate_groups, "fann_get_cascade_num_candidate_groups");
            bindFunc(cast(void**)&fann_set_cascade_num_candidate_groups, "fann_set_cascade_num_candidate_groups");
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
