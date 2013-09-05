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
module derelict.fann.wrapper;

import std.string;
import std.conv;
import derelict.fann.fann;


final class FANNLib
{
    public
    {
        this()
        {
            DerelictFANN.load();
        }

        ~this()
        {
            close();
        }

        void close()
        {
            DerelictFANN.unload();
        }

        void runtimeCheck()
        {
            FANN_ERROR lastErrDat;
            fann_errno_enum lastErrno = fann_get_errno(&lastErrDat);
            if (FANN_E_NO_ERROR != lastErrno)
            {
                // TODO sanitize UTF-8
                const(char)* msg = fann_get_errstr(&lastErrDat);
                throw new FANNException(to!string(msg));
            }
        }
    }
}

class FANNException : Exception
{
    public
    {
        this(string msg)
        {
            super(msg);
        }
    }
}


// ANN stands for Artificial Neural Network
final class ANN
{
    public
    {
        static ANN createStandard(FANNLib lib, uint[] layers)
        {
            FANN* fann = fann_create_standard_array(layers.length, layers.ptr);
            lib.runtimeCheck();
            assert(fann !is null);
            return new ANN(lib, fann);
        }

        static ANN createSparse(FANNLib lib, float connectionRate, uint[] layers)
        {
            FANN* fann = fann_create_sparse_array(connectionRate, layers.length, layers.ptr);
            lib.runtimeCheck();
            assert(fann !is null);
            return new ANN(lib, fann);
        }

        static ANN createSparse(FANNLib lib, uint[] layers)
        {
            FANN* fann = fann_create_shortcut_array(layers.length, layers.ptr);
            lib.runtimeCheck();
            assert(fann !is null);
            return new ANN(lib, fann);
        }

        static ANN createFromFile(FANNLib lib, string filename)
        {
            FANN* fann = fann_create_from_file(toStringz(filename));
            lib.runtimeCheck();
            assert(fann !is null);
            return new ANN(lib, fann);
        }

        ~this()
        {
            close();
        }
        
        void close()
        {
            if (_fann !is null)
            {
                fann_destroy(_fann);
                _fann = null;
            }
        }

        void save(string filename)
        {
            fann_save(_fann, toStringz(filename));
            _lib.runtimeCheck();
        }

        void saveToFixed(string filename)
        {
            fann_save_to_fixed(_fann, toStringz(filename));
            _lib.runtimeCheck();
        }

        fann_type* run(fann_type*	input)
        {
            fann_type* res = fann_run(_fann, input);
            _lib.runtimeCheck();
            return res;
        }

        void printConnections()
        {
            fann_print_connections(_fann);
        }

        void printParameters()
        {
            fann_print_parameters(_fann);
        }

        void randomizeWeights(fann_type minWeight, fann_type maxWeight)
        {
            fann_randomize_weights(_fann, minWeight, maxWeight);
            _lib.runtimeCheck();
        }

        uint numInputs()
        {
            return fann_get_num_input(_fann);
        }

        uint numOutputs()
        {
            return fann_get_num_output(_fann);
        }

        uint numLayers()
        {
            return fann_get_num_layers(_fann);
        }

        uint totalNeurons()
        {
            return fann_get_total_neurons(_fann);
        }

        uint totalConnections()
        {
            return fann_get_total_connections(_fann);
        }

        network_type_enum networkType()
        {
            return fann_get_network_type(_fann);
        }

        float connectionRate()
        {
            return fann_get_connection_rate(_fann);
        }
    }

    private
    {
        this(FANNLib lib, FANN* fann)
        {
            _lib = lib;
            _fann = fann;
        }

        FANN* _fann;
        FANNLib _lib;
    }
}
