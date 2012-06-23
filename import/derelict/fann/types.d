/*
 * Copyright (c) 2004-2008 Derelict Developers
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
module derelict.fann.types;

public import core.stdc.stdio : FILE;


version(FANN_Fixed)
{
    alias int fann_type;
}
else version(FANN_Double)
{
    alias double fann_type;
}
else
{
    alias float fann_type;
}

alias fann_type[65536] FANN_TYPE_ARRAY;


align(1) struct FANN_NEURON
{
    uint first_con;
    uint last_con;
    fann_type sum;
    fann_type value;
    fann_type activation_steepness;
    uint activation_function;
}

align(1) struct FANN_LAYER
{
    FANN_NEURON* first_neuro;
    FANN_NEURON* last_neuro;
}

align(1) struct FANN
{
    uint errno_f;
    FILE* error_log;
    char* errstr;
    float learning_rate;
    float learning_momentum;
    float connection_rate;

    uint network_type;

    FANN_LAYER* first_layer;
    FANN_LAYER* last_layer;

    uint total_neurons;
    uint num_input;
    uint num_output;

    fann_type* weights;

    FANN_NEURON** connections;

    fann_type* train_errors;

    uint training_algorithm;

    version(FANN_Fixed)
    {
        uint decimal_point;
        uint multiplier;
        fann_type[6] sigmoid_results;
        fann_type[6] sigmoid_values;
        fann_type[6] symmetric_results;
        fann_type[6] symmetric_values;
    }

    uint total_connections;
    fann_type* output;
    uint num_MSE;
    float MSE_value;
    uint num_bit_fail;
    fann_type bit_fail_limit;
    uint train_error_function;
    uint train_stop_function;
    void* callback;
    void* user_data;
    float cascade_output_change_fraction;
    uint cascade_output_stagnation_epochs;
    float cascade_candidate_change_fraction;
    uint cascade_candidate_stagnation_epochs;
    uint cascade_best_candidate;
    fann_type cascade_candidate_limit;
    fann_type cascade_weight_multiplier;
    uint cascade_max_out_epochs;
    uint cascade_max_cand_epochs;
    uint* cascade_activation_functions;
    uint cascade_activation_functions_count;
    fann_type* cascade_activation_steepnesses;
    uint cascade_activation_steepnesses_count;
    uint cascade_num_candidate_groups;
    fann_type* cascade_candidate_scores;
    uint total_neurons_allocated;
    uint total_connections_allocated;
    float quickprop_decay;
    float quickprop_mu;
    float rprop_increase_factor;
    float rprop_decrease_factor;
    float rprop_delta_min;
    float rprop_delta_max;
    float rprop_delta_zero;
    fann_type* train_slopes;
    fann_type* prev_steps;
    fann_type* prev_train_slopes;
    fann_type* prev_weights_deltas;

    version(FANN_Fixed)
    {
    }
    else
    {
        float* scale_mean_in;
        float* scale_deviation_in;
        float* scale_new_min_in;
        float* scale_factor_in;
        float* scale_mean_out;
        float* scale_deviation_out;
        float* scale_new_min_out;
        float* scale_factor_out;
    }
}

align(1) struct FANN_TRAIN_DATA
{
    uint errno_f;
    FILE* erro_log;
    char* errstr;
    uint num_data;
    uint num_input;
    uint num_ouput;
    fann_type** input;
    fann_type** output;
}


align(1) struct FANN_CONNECTION
{
    uint from_neuron;
    uint to_neuron;
    fann_type weight;
}

align(1) struct FANN_ERROR
{
    uint errno_f;
    FILE* error_log;
    char* errstr;
}

        
alias uint _Fann_Train;
enum : _Fann_Train
{
    FANN_TRAIN_INCREMENTAL,
    FANN_TRAIN_BATCH,
    FANN_TRAIN_RPROP,
    FANN_TRAIN_QUICKPROP 
}


alias uint _Fann_Error_Func;
enum : _Fann_Error_Func
{
    FANN_ERRORFUNC_LINEAR,
    FANN_ERRORFUNC_TANH
}

alias uint _Fann_Activation_Func;
enum : _Fann_Activation_Func
{
    FANN_LINEAR,
    FANN_THRESHOLD,
    FANN_THRESHOLD_SYMMETRIC,
    FANN_SIGMOID,
    FANN_SIGMOID_STEPWISE,
    FANN_SIGMOID_SYMMETRIC,
    FANN_SIGMOID_SYMMETRIC_STEPWISE,
    FANN_GAUSSIAN,
    FANN_GAUSSIAN_SYMMETRIC,
    FANN_GAUSSIAN_STEPWISE,
    FANN_ELLIOT,
    FANN_ELLIOT_SYMMETRIC,
    FANN_LINEAR_PIECE,
    FANN_LINEAR_PIECE_SYMMETRIC,
    FANN_SIN_SYMMETRIC,
    FANN_COS_SYMMETRIC,
    FANN_SIN,
    FANN_COS
}


alias uint _Fann_ErroNo;
enum : _Fann_ErroNo
{
    FANN_E_NO_ERROR,
    FANN_E_CANT_OPEN_CONFIG_R,
    FANN_E_CANT_OPEN_CONFIG_W,
    FANN_E_WRONG_CONFIG_VERSION,
    FANN_E_CANT_READ_CONFIG,
    FANN_E_CANT_READ_NEURON,
    FANN_E_CANT_READ_CONNECTIONS,
    FANN_E_WRONG_NUM_CONNECTIONS,
    FANN_E_CANT_OPEN_TD_W,
    FANN_E_CANT_OPEN_TD_R,
    FANN_E_CANT_READ_TD,
    FANN_E_CANT_ALLOCATE_MEM,
    FANN_E_CANT_TRAIN_ACTIVATION,
    FANN_E_CANT_USE_ACTIVATION,
    FANN_E_TRAIN_DATA_MISMATCH,
    FANN_E_CANT_USE_TRAIN_ALG,
    FANN_E_TRAIN_DATA_SUBSET,
    FANN_E_INDEX_OUT_OF_BOUND,
    FANN_E_SCALE_NOT_PRESENT
}

alias uint _Fann_Stop_Func;
enum : _Fann_Stop_Func
{
    FANN_STOPFUNC_MSE,
    FANN_STOPFUNC_BIT
}

alias uint _Fann_Net_Type;
enum : _Fann_Net_Type
{
    FANN_NETTYPE_LAYER,
    FANN_NETTYPE_SHORTCUT
}

        
alias extern(C) int function(FANN* ann, 
                             FANN_TRAIN_DATA* train, 
                             uint max_epoch,
                             uint epochs_between_reports, 
                             float desired_error, 
                             uint epochs) FANN_CALLBACK;

alias extern(C) void function(uint num,
                              uint num_input,
                              uint num_output,
                              fann_type* input,
                              fann_type* output) USER_FUNCTION;

