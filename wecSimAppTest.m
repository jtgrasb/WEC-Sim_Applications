function results = wecSimAppTest(testsPath)   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Copyright 2014 National Renewable Energy Laboratory and National 
    % Technology & Engineering Solutions of Sandia, LLC (NTESS). 
    % Under the terms of Contract DE-NA0003525 with NTESS, 
    % the U.S. Government retains certain rights in this software.
    %
    % Licensed under the Apache License, Version 2.0 (the "License");
    % you may not use this file except in compliance with the License.
    % You may obtain a copy of the License at
    %
    %     http://www.apache.org/licenses/LICENSE-2.0
    %
    % Unless required by applicable law or agreed to in writing, software
    % distributed under the License is distributed on an "AS IS" BASIS,
    % WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    % See the License for the specific language governing permissions and
    % limitations under the License.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % wecSimAppTest runs the WEC-Sim Applications continuous integration 
    %               testing suite.
    %
    %   results = wecSimAppTest
    %        returns a matlab.unittest.TestResult object for all tests
    %        in this repository
    %
    %   results = wecSimAppTest(testsPath)
    %        returns a matlab.unittest.TestResult object for the tests 
    %        located under the given path    
    %
    %   runtests <testDirectory>
    %       runs a specific test directory (e.g., Controls)
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    arguments
        testsPath string = "."
    end
    % Import MATLAB unitttest
    import matlab.unittest.TestSuite;
    import matlab.unittest.TestRunner;
    import matlab.unittest.plugins.DiagnosticsRecordingPlugin
    % Define the test suite
    suite = TestSuite.fromFolder(testsPath, ...
                                 'IncludingSubfolders', true);    
    % Build the runner
    runner = TestRunner.withTextOutput;
    runner.addPlugin(DiagnosticsRecordingPlugin);    
    % Run the tests
    results = runner.run(suite);
    results.table
end
