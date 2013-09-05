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
module derelict.fann.funcs;


private
{
    import derelict.util.loader;
    import derelict.fann.types;
}

extern(C)
{
    version(FANN_Fixed)
    {
        alias nothrow uint function(FANN* ann) da_fann_get_decimal_point;
        alias nothrow uint function(FANN* ann) da_fann_get_multiplier;
    }
    else
    {
        alias nothrow void function(FANN* ann, fann_type* input, fann_type* desired_output) da_fann_train;
        alias nothrow void function(FANN* ann, FANN_TRAIN_DATA* data, uint max_epochs, uint epochs_between_reports, float desired_error) da_fann_train_on_data;
        alias nothrow void function(FANN* ann, char* filename, uint max_epochs, uint epochs_between_reports, float desired_error) da_fann_train_on_file;
        alias nothrow float function(FANN* ann, FANN_TRAIN_DATA* data) da_fann_train_epoch;
        alias nothrow float function(FANN* ann, FANN_TRAIN_DATA* data) da_fann_test_data;
    }
    alias nothrow FANN* function(uint num_layers, ...) da_fann_create_standard;
    alias nothrow FANN* function(float connection_rate, uint num_layers, ...) da_fann_create_sparse;
    alias nothrow FANN* function(float connection_rate) da_fann_create_shortcut;
    alias nothrow FANN* function(uint num_layers, const(uint)* layers) da_fann_create_standard_array;
    alias nothrow FANN* function(float connection_rate, uint num_layers, const(uint)* layers) da_fann_create_sparse_array;
    alias nothrow FANN* function(uint num_layers, const(uint)* layers) da_fann_create_shortcut_array;
    alias nothrow void function(FANN* ann) da_fann_destroy;
    alias nothrow fann_type* function(FANN* ann, fann_type* input) da_fann_run;
    alias nothrow void function(FANN* ann, fann_type min_weight, fann_type max_weight) da_fann_randomize_weights;
    alias nothrow void function(FANN* ann, FANN_TRAIN_DATA* train_data) da_fann_init_weights;
    alias nothrow void function(FANN* ann) da_fann_print_connections;
    alias nothrow void function(FANN* ann) da_fann_print_parameters;
    alias nothrow uint function(FANN* ann) da_fann_get_num_input;
    alias nothrow uint function(FANN* ann) da_fann_get_num_output;
    alias nothrow uint function(FANN* ann) da_fann_get_total_neurons;
    alias nothrow uint function(FANN* ann) da_fann_get_total_connections;
    alias nothrow uint function(FANN* ann) da_fann_get_network_type;
    alias nothrow float function(FANN* ann) da_fann_get_connection_rate;
    alias nothrow uint function(FANN* ann) da_fann_get_num_layers;
    alias nothrow void function(FANN* ann, uint* layers) da_fann_get_layer_array;
    alias nothrow void function(FANN* ann, uint* bias) da_fann_get_bias_array;
    alias nothrow void function(FANN* ann, FANN_CONNECTION* connections) da_fann_get_connection_array;
    alias nothrow void function(FANN* ann, FANN_CONNECTION* connections, uint num_connection) da_fann_set_weight_array;
    alias nothrow void function(FANN* ann, uint from_neuron, uint to_neuron, fann_type weight) da_fann_set_weight;
    alias nothrow void function(FANN* ann, void* user_data) da_fann_set_user_data;
    alias nothrow void* function(FANN* ann) da_fann_get_user_data;
    alias nothrow FANN* function(const(char)* configuration_file) da_fann_create_from_file;
    alias nothrow void function(FANN* ann, const(char)* configuration_file) da_fann_save;
    alias nothrow int function(FANN* ann, const(char)* configuration_file) da_fann_save_to_fixed;
    alias nothrow fann_type* function(FANN* ann, fann_type* input, fann_type* desired_output) da_fann_test;
    alias nothrow float function(FANN* ann) da_fann_get_MSE;
    alias nothrow uint function(FANN* ann) da_fann_get_bit_fail;
    alias nothrow void function(FANN* ann) da_fann_reset_MSE;
    alias nothrow FANN_TRAIN_DATA* function(const(char)* filename) da_fann_read_train_from_file;
    alias nothrow FANN_TRAIN_DATA* function(uint num_data, uint num_input, uint num_output, USER_FUNCTION user_function) da_fann_create_train_from_callback;
    alias nothrow void function(FANN_TRAIN_DATA* train_data) da_fann_destroy_train;
    alias nothrow void function(FANN_TRAIN_DATA* train_Data) da_fann_shuffle_train_data;
    alias nothrow void function(FANN* ann, FANN_TRAIN_DATA* data) da_fann_scale_train;
    alias nothrow void function(FANN* ann, FANN_TRAIN_DATA* data) da_fann_descale_train;
    alias nothrow int function(FANN* ann, const(FANN_TRAIN_DATA)* data, float new_input_min, float new_input_max) da_fann_set_input_scaling_params;
    alias nothrow int function(FANN* ann, const(FANN_TRAIN_DATA)* data, float new_output_min, float new_output_max) da_fann_set_output_scaling_params;
    alias nothrow int function(FANN* ann, const(FANN_TRAIN_DATA)* data, float new_input_min, float new_input_max, float new_output_min, float new_output_max) da_fann_set_scaling_params;
    alias nothrow int function(FANN* ann) da_fann_clear_scaling_params;
    alias nothrow void function(FANN* ann, fann_type* input_vector) da_fann_scale_input;
    alias nothrow void function(FANN* ann, fann_type* output_vector) da_fann_scale_output;
    alias nothrow void function(FANN* ann, fann_type* input_vector) da_fann_descale_input;
    alias nothrow void function(FANN* ann, fann_type* output_vector) da_fann_descale_output;
    alias nothrow void function(FANN_TRAIN_DATA* train_data, fann_type new_min, fann_type new_max) da_fann_scale_input_train_data;
    alias nothrow void function(FANN_TRAIN_DATA* train_data, fann_type new_min, fann_type new_max) da_fann_scale_output_train_data;
    alias nothrow void function(FANN_TRAIN_DATA* train_data, fann_type new_min, fann_type new_max) da_fann_scale_train_data;
    alias nothrow FANN_TRAIN_DATA* function(FANN_TRAIN_DATA* data1, FANN_TRAIN_DATA* data2) da_fann_merge_train_data;
    alias nothrow FANN_TRAIN_DATA* function(FANN_TRAIN_DATA* data) da_fann_duplicate_train_data;
    alias nothrow FANN_TRAIN_DATA* function(FANN_TRAIN_DATA* data, uint pos, uint length) da_fann_subset_train_data;
    alias nothrow uint function(FANN_TRAIN_DATA* data) da_fann_length_train_data;
    alias nothrow uint function(FANN_TRAIN_DATA* data) da_fann_num_input_train_data;
    alias nothrow uint function(FANN_TRAIN_DATA* data) da_fann_num_output_train_data;
    alias nothrow int function(FANN_TRAIN_DATA* data, const(char)* filename) da_fann_save_train;
    alias nothrow int function(FANN_TRAIN_DATA* data, const(char)* fileName, uint decimal_point) da_fann_save_train_to_fixed;
    alias nothrow uint function(FANN* ann) da_fann_get_training_algorithm;
    alias nothrow void function(FANN* ann, uint training_algorithm) da_fann_set_training_algorithm;
    alias nothrow float function(FANN* ann) da_fann_get_learning_rate;
    alias nothrow void function(FANN* ann, float learning_rate) da_fann_set_learning_rate;
    alias nothrow float function(FANN* ann) da_fann_get_learning_momentum;
    alias nothrow void function(FANN* ann, float learning_momentum) da_fann_set_learning_momentum;
    alias nothrow uint function(FANN* ann, int layer, int neuron) da_fann_get_activation_function;
    alias nothrow void function(FANN* ann, uint activation_function, int layer, int neuron) da_fann_set_activation_function;
    alias nothrow void function(FANN* ann, uint activation_function, int layer) da_fann_set_activation_function_layer;
    alias nothrow void function(FANN* ann, uint activation_function) da_fann_set_activation_function_hidden;
    alias nothrow void function(FANN* ann, uint activation_function) da_fann_set_activation_function_output;
    alias nothrow fann_type function(FANN* ann, int layer, int neuron) da_fann_get_activation_steepness;
    alias nothrow void function(FANN* ann, fann_type steepness, int layer, int neuron) da_fann_set_activation_steepness;
    alias nothrow void function(FANN* ann, fann_type steepness, int layer) da_fann_set_activation_steepness_layer;
    alias nothrow void function(FANN* ann, fann_type steepness) da_fann_set_activation_steepness_hidden;
    alias nothrow void function(FANN* ann, fann_type steepness) da_fann_set_activation_steepness_output;
    alias nothrow uint function(FANN* ann) da_fann_get_train_error_function;
    alias nothrow void function(FANN* ann, uint train_error_function) da_fann_set_train_error_function;
    alias nothrow uint function(FANN* ann) da_fann_get_train_stop_function;
    alias nothrow void function(FANN* ann, uint train_stop_function) da_fann_set_train_stop_function;
    alias nothrow fann_type function(FANN* ann) da_fann_get_bit_fail_limit;
    alias nothrow void function(FANN* ann, fann_type bit_fail_limit) da_fann_set_bit_fail_limit;
    alias nothrow void function(FANN* ann, FANN_CALLBACK callback) da_fann_set_callback;
    alias nothrow float function(FANN* ann) da_fann_get_quickprop_decay;
    alias nothrow void function(FANN* ann, float quickprop_decay) da_fann_set_quickprop_decay;
    alias nothrow float function(FANN* ann) da_fann_get_quickprop_mu;
    alias nothrow void function(FANN* ann, float mu) da_fann_set_quickprop_mu;
    alias nothrow float function(FANN* ann) da_fann_get_rprop_increase_factor;
    alias nothrow void function(FANN* ann, float rprop_increase_factor) da_fann_set_rprop_increase_factor;
    alias nothrow float function(FANN* ann) da_fann_get_rprop_decrease_factor;
    alias nothrow void function(FANN* ann, float rprop_decrease_factor) da_fann_set_rprop_decrease_factor;
    alias nothrow float function(FANN* ann) da_fann_get_rprop_delta_min;
    alias nothrow void function(FANN* ann, float rprop_delta_min) da_fann_set_rprop_delta_min;
    alias nothrow float function(FANN* ann) da_fann_get_rprop_delta_max;
    alias nothrow void function(FANN* ann, float rprop_delta_max) da_fann_set_rprop_delta_max;
    alias nothrow float function(FANN* ann) da_fann_get_rprop_delta_zero;
    alias nothrow void function(FANN* ann, float rprop_delta_zero) da_fann_set_rprop_delta_zero;
    alias nothrow void function(FANN_ERROR* errdat, FILE* log_file) da_fann_set_error_log;
    alias nothrow uint function(FANN_ERROR* errdat) da_fann_get_errno;
    alias nothrow void function(FANN_ERROR* errdat) da_fann_reset_errno;
    alias nothrow void function(FANN_ERROR* errdat) da_fann_reset_errstr;
    alias nothrow char* function(FANN_ERROR* errdat) da_fann_get_errstr;
    alias nothrow void function(FANN_ERROR* errdat) da_fann_print_error;
    alias nothrow void function(FANN* ann, FANN_TRAIN_DATA* data, uint max_neurons, uint neurons_between_reports, float desired_error) da_fann_cascadetrain_on_data;
    alias nothrow void function(FANN* ann, const(char)* filename, uint max_neurons, uint neurons_between_reports, float desired_error) da_fann_cascadetrain_on_file;
    alias nothrow float function(FANN* ann) da_fann_get_cascade_output_change_fraction;
    alias nothrow void function(FANN* ann, float cascade_output_change_fraction) da_fann_set_cascade_output_change_fraction;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_output_stagnation_epochs;
    alias nothrow void function(FANN* ann, uint cascade_output_stagnation_epochs) da_fann_set_cascade_output_stagnation_epochs;
    alias nothrow float function(FANN* ann) da_fann_get_cascade_candidate_change_fraction;
    alias nothrow void function(FANN* ann, float cascade_candidate_change_fraction) da_fann_set_cascade_candidate_change_fraction;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_candidate_stagnation_epochs;
    alias nothrow void function(FANN* ann, uint cascade_candidate_stagnation_epochs) da_fann_set_cascade_candidate_stagnation_epochs;
    alias nothrow fann_type function(FANN* ann) da_fann_get_cascade_weight_multiplier;
    alias nothrow void function(FANN* ann, fann_type cascade_weight_multiplier) da_fann_set_cascade_weight_multiplier;
    alias nothrow fann_type function(FANN* ann) da_fann_get_cascade_candidate_limit;
    alias nothrow void function(FANN* ann, fann_type cascade_candidate_limit) da_fann_set_cascade_candidate_limit;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_max_out_epochs;
    alias nothrow void function(FANN* ann, uint cascade_max_out_epochs) da_fann_set_cascade_max_out_epochs;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_max_cand_epochs;
    alias nothrow void function(FANN* ann, uint cascade_max_cand_epochs) da_fann_set_cascade_max_cand_epochs;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_num_candidates;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_activation_functions_count;
    alias nothrow uint* function(FANN* ann) da_fann_get_cascade_activation_functions;
    alias nothrow void function(FANN* ann, uint* cascade_activation_functions, uint cascade_activation_functions_count) da_fann_set_cascade_activation_functions;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_activation_steepnesses_count;
    alias nothrow fann_type* function(FANN* ann) da_fann_get_cascade_activation_steepnesses;
    alias nothrow void function(FANN* ann, fann_type* cascade_activation_steepnesses, uint cascade_activation_steepnesses_count) da_fann_set_cascade_activation_steepnesses;
    alias nothrow uint function(FANN* ann) da_fann_get_cascade_num_candidate_groups;
    alias nothrow void function(FANN* ann, uint cascade_num_candidate_groups) da_fann_set_cascade_num_candidate_groups;
}

__gshared
{
    version(FANN_Fixed)
    {
        da_fann_get_decimal_point fann_get_decimal_point;
        da_fann_get_multiplier fann_get_multiplier;
    }
    else
    {
        da_fann_train fann_train;
        da_fann_train_on_data fann_train_on_data;
        da_fann_train_on_file fann_train_on_file;
        da_fann_train_epoch fann_train_epoch;
        da_fann_test_data fann_test_data;
    }

    da_fann_create_standard fann_create_standard;
    da_fann_create_sparse fann_create_sparse;
    da_fann_create_shortcut fann_create_shortcut;
    da_fann_create_standard_array fann_create_standard_array;
    da_fann_create_sparse_array fann_create_sparse_array;
    da_fann_create_shortcut_array fann_create_shortcut_array;
    da_fann_destroy fann_destroy;
    da_fann_run fann_run;
    da_fann_randomize_weights fann_randomize_weights;
    da_fann_init_weights fann_init_weights;
    da_fann_print_connections fann_print_connections;
    da_fann_print_parameters fann_print_parameters;
    da_fann_get_num_input fann_get_num_input;
    da_fann_get_num_output fann_get_num_output;
    da_fann_get_total_neurons fann_get_total_neurons;
    da_fann_get_total_connections fann_get_total_connections;
    da_fann_get_network_type fann_get_network_type;
    da_fann_get_connection_rate fann_get_connection_rate;
    da_fann_get_num_layers fann_get_num_layers;
    da_fann_get_layer_array fann_get_layer_array;
    da_fann_get_bias_array fann_get_bias_array;
    da_fann_get_connection_array fann_get_connection_array;
    da_fann_set_weight_array fann_set_weight_array;
    da_fann_set_weight fann_set_weight;
    da_fann_set_user_data fann_set_user_data;
    da_fann_get_user_data fann_get_user_data;
    da_fann_create_from_file fann_create_from_file;
    da_fann_save fann_save;
    da_fann_save_to_fixed fann_save_to_fixed;
    da_fann_test fann_test;
    da_fann_get_MSE fann_get_MSE;
    da_fann_get_bit_fail fann_get_bit_fail;
    da_fann_reset_MSE fann_reset_MSE;
    da_fann_read_train_from_file fann_read_train_from_file;
    da_fann_create_train_from_callback fann_create_train_from_callback;
    da_fann_destroy_train fann_destroy_train;
    da_fann_shuffle_train_data fann_shuffle_train_data;
    da_fann_scale_train fann_scale_train;
    da_fann_descale_train fann_descale_train;
    da_fann_set_input_scaling_params fann_set_input_scaling_params;
    da_fann_set_output_scaling_params fann_set_output_scaling_params;
    da_fann_set_scaling_params fann_set_scaling_params;
    da_fann_clear_scaling_params fann_clear_scaling_params;
    da_fann_scale_input fann_scale_input;
    da_fann_scale_output fann_scale_output;
    da_fann_descale_input fann_descale_input;
    da_fann_descale_output fann_descale_output;
    da_fann_scale_input_train_data fann_scale_input_train_data;
    da_fann_scale_output_train_data fann_scale_output_train_data;
    da_fann_scale_train_data fann_scale_train_data;
    da_fann_merge_train_data fann_merge_train_data;
    da_fann_duplicate_train_data fann_duplicate_train_data;
    da_fann_subset_train_data fann_subset_train_data;
    da_fann_length_train_data fann_length_train_data;
    da_fann_num_input_train_data fann_num_input_train_data;
    da_fann_num_output_train_data fann_num_output_train_data;
    da_fann_save_train fann_save_train;
    da_fann_save_train_to_fixed fann_save_train_to_fixed;
    da_fann_get_training_algorithm fann_get_training_algorithm;
    da_fann_set_training_algorithm fann_set_training_algorithm;
    da_fann_get_learning_rate fann_get_learning_rate;
    da_fann_set_learning_rate fann_set_learning_rate;
    da_fann_get_learning_momentum fann_get_learning_momentum;
    da_fann_set_learning_momentum fann_set_learning_momentum;
    da_fann_get_activation_function fann_get_activation_function;
    da_fann_set_activation_function fann_set_activation_function;
    da_fann_set_activation_function_layer fann_set_activation_function_layer;
    da_fann_set_activation_function_hidden fann_set_activation_function_hidden;
    da_fann_set_activation_function_output fann_set_activation_function_output;
    da_fann_get_activation_steepness fann_get_activation_steepness;
    da_fann_set_activation_steepness fann_set_activation_steepness;
    da_fann_set_activation_steepness_layer fann_set_activation_steepness_layer;
    da_fann_set_activation_steepness_hidden fann_set_activation_steepness_hidden;
    da_fann_set_activation_steepness_output fann_set_activation_steepness_output;
    da_fann_get_train_error_function fann_get_train_error_function;
    da_fann_set_train_error_function fann_set_train_error_function;
    da_fann_get_train_stop_function fann_get_train_stop_function;
    da_fann_set_train_stop_function fann_set_train_stop_function;
    da_fann_get_bit_fail_limit fann_get_bit_fail_limit;
    da_fann_set_bit_fail_limit fann_set_bit_fail_limit;
    da_fann_set_callback fann_set_callback;
    da_fann_get_quickprop_decay fann_get_quickprop_decay;
    da_fann_set_quickprop_decay fann_set_quickprop_decay;
    da_fann_get_quickprop_mu fann_get_quickprop_mu;
    da_fann_set_quickprop_mu fann_set_quickprop_mu;
    da_fann_get_rprop_increase_factor fann_get_rprop_increase_factor;
    da_fann_set_rprop_increase_factor fann_set_rprop_increase_factor;
    da_fann_get_rprop_decrease_factor fann_get_rprop_decrease_factor;
    da_fann_set_rprop_decrease_factor fann_set_rprop_decrease_factor;
    da_fann_get_rprop_delta_min fann_get_rprop_delta_min;
    da_fann_set_rprop_delta_min fann_set_rprop_delta_min;
    da_fann_get_rprop_delta_max fann_get_rprop_delta_max;
    da_fann_set_rprop_delta_max fann_set_rprop_delta_max;
    da_fann_get_rprop_delta_zero fann_get_rprop_delta_zero;
    da_fann_set_rprop_delta_zero fann_set_rprop_delta_zero;
    da_fann_set_error_log fann_set_error_log;
    da_fann_get_errno fann_get_errno;
    da_fann_reset_errno fann_reset_errno;
    da_fann_reset_errstr fann_reset_errstr;
    da_fann_get_errstr fann_get_errstr;
    da_fann_print_error fann_print_error;
    da_fann_cascadetrain_on_data fann_cascadetrain_on_data;
    da_fann_cascadetrain_on_file fann_cascadetrain_on_file;
    da_fann_get_cascade_output_change_fraction fann_get_cascade_output_change_fraction;
    da_fann_set_cascade_output_change_fraction fann_set_cascade_output_change_fraction;
    da_fann_get_cascade_output_stagnation_epochs fann_get_cascade_output_stagnation_epochs;
    da_fann_set_cascade_output_stagnation_epochs fann_set_cascade_output_stagnation_epochs;
    da_fann_get_cascade_candidate_change_fraction fann_get_cascade_candidate_change_fraction;
    da_fann_set_cascade_candidate_change_fraction fann_set_cascade_candidate_change_fraction;
    da_fann_get_cascade_candidate_stagnation_epochs fann_get_cascade_candidate_stagnation_epochs;
    da_fann_set_cascade_candidate_stagnation_epochs fann_set_cascade_candidate_stagnation_epochs;
    da_fann_get_cascade_weight_multiplier fann_get_cascade_weight_multiplier;
    da_fann_set_cascade_weight_multiplier fann_set_cascade_weight_multiplier;
    da_fann_get_cascade_candidate_limit fann_get_cascade_candidate_limit;
    da_fann_set_cascade_candidate_limit fann_set_cascade_candidate_limit;
    da_fann_get_cascade_max_out_epochs fann_get_cascade_max_out_epochs;
    da_fann_set_cascade_max_out_epochs fann_set_cascade_max_out_epochs;
    da_fann_get_cascade_max_cand_epochs fann_get_cascade_max_cand_epochs;
    da_fann_set_cascade_max_cand_epochs fann_set_cascade_max_cand_epochs;
    da_fann_get_cascade_num_candidates fann_get_cascade_num_candidates;
    da_fann_get_cascade_activation_functions_count fann_get_cascade_activation_functions_count;
    da_fann_get_cascade_activation_functions fann_get_cascade_activation_functions;
    da_fann_set_cascade_activation_functions fann_set_cascade_activation_functions;
    da_fann_get_cascade_activation_steepnesses_count fann_get_cascade_activation_steepnesses_count;
    da_fann_get_cascade_activation_steepnesses fann_get_cascade_activation_steepnesses;
    da_fann_set_cascade_activation_steepnesses fann_set_cascade_activation_steepnesses;
    da_fann_get_cascade_num_candidate_groups fann_get_cascade_num_candidate_groups;
    da_fann_set_cascade_num_candidate_groups fann_set_cascade_num_candidate_groups;
}



