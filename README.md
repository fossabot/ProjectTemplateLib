
CMake Library Project Template
===========
[![Build status](https://ci.appveyor.com/api/projects/status/irafbluexmulat6u/branch/master?svg=true)](https://ci.appveyor.com/project/jgonzalezdr/projecttemplatelib/branch/master)
[![codecov](https://codecov.io/gh/jgonzalezdr/ProjectTemplateLib/branch/master/graph/badge.svg)](https://codecov.io/gh/jgonzalezdr/ProjectTemplateLib)
## About

This repository is just a template for a library built using [CMake](https://cmake.org/), and using [cpputest](http://cpputest.github.io/) for unit test execution.

## Usage

1.  Download all the [files from this repository as a ZIP file](https://github.com/jgonzalezdr/projecttemplatelib/archive/master.zip) and unzip them to your project base directory.

2. Edit the top level `CMakefile.txt` and replace _ProjectTemplate_ in the project command with your own project name (leave the .Top suffix).

3. Put the headers for your public functions and classes in `prod/include/`.

4. Put the headers for your private functions and classes and the implementation files in `prod/sources/`.

5. Edit `prod/CMakefile.txt` and replace _ProjectTemplate_ in the project command with your own project name (this time without any suffix). This will be the base name for the library file. You may also update your project version in the project command.

6. Edit `prod/CMakefile.txt` and set the list of source and header files, and modify any other parameters that you like.

7. Add your common mocks and expectation functions to `test/Mocks`. 

8. To create unit tests, copy the `test/TestTemplate/` directory to another directory under `test/` renaming it with the test name, then:
   - Rename `UnitUnderTest_test.cpp` according to your test name (recommend leaving the _ _test_ suffix).
   - Edit the test's `CMakefile.txt` and replace _ProjectTemplate_ in the project command with your own project name and test name (e.g. "_YourProjectName_.Test._YourTestName_").
   - Edit the test's `CMakefile.txt` and set the list of production source files to be tested, and the list of test source files (test, mocks, other test helper functions, etc.).
   - Edit your test implementation file to add your tests.

9. Edit `test/CMakefile.txt` and replace _ProjectTemplate_ in the project command with your own project name (leave the .AllTest suffix).

10. Edit `test/CMakefile.txt` and add all the subdirectories for your tests.

11. Delete all the exemple files.

12. Replace `LICENSE.txt` with your project's license file.

13. Create a build directory under the top directory (e.g. `build/`), and inside it execute `cmake .. G "<GeneratorOfYourChoice>"` (add any other configuration options that you like).

## CMake Project Options

| OPTION                | Description                                                                 |
| -                     | -                                                                           |
| `-DCMAKE_BUILD_TYPE`  | Adds `Coverage` to standard build types (only for single-config generators) |
| `-DENABLE_TEST`       | Enables compilation and execution of tests                                  |
| `-DCPPUTEST_HOME`     | Path to your CppUTest installation directory                                |
| `-DENABLE_INSTALLER`  | Enables generation of an installer package                                  |
| `-DCI_MODE`           | Enables Continous Integration mode                                          |
| `-DCPPUTEST_HOME`     | Path to your CppUTest installation directory                                |
| `-DCOVERAGE`          | Enables code coverage in tests (only for multi-config generators)           |
| `-DCOVERAGE_VERBOSE`  | Enables verbose code coverage                                               |

## Requirements

- [cmake](https://cmake.org/) (tested with v3.7.1 and 3.17.2)
- A C/C++ compiler, either:
  - [MinGW-w64](https://sourceforge.net/projects/mingw-w64/) (tested with x86_64-6.4.0-posix-seh-rt_v5-rev0 and x86_64-8.1.0-posix-seh-rt_v6-rev0)
  - [Microsoft Visual Studio](https://www.visualstudio.com/es/downloads/) (tested with Visual Studio Community 2015, 2017 and 2019)
- [CppUTest](http://cpputest.github.io/) [Optional, not needed if tests are disabled] (tested with v3.7.1, v3.7.2 and v3.8)
- [LCOV](https://github.com/jgonzalezdr/lcov/releases) [Optional, needed if tests and coverage are enabled using GCC/MinGW] (tested with v1.11.1w)
- [OpenCppCoverage](https://github.com/OpenCppCoverage/OpenCppCoverage) [Optional, needed if tests and coverage are enabled using Visual Studio 2017 or 2019] (tested with v0.9.6.1 and v0.9.8.0)