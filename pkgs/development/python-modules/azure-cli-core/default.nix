{ stdenv, buildPythonPackage, fetchPypi
, adal
, argcomplete
, azure-cli-telemetry
, colorama
, humanfriendly
, jmespath
, knack
, msrest
, msrestazure
, paramiko
, pip
, pygments
, pyjwt
, pyopenssl
, pyyaml
, requests
, six
, tabulate
, azure-mgmt-resource
, azure-cli-nspkg
, antlr4-python3-runtime
}:

buildPythonPackage rec {
  pname = "azure_cli_core";
  version = "2.0.43";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    sha256 = "1qa1nw75k5xi4ndl77rw17mfgnv7j88f03hq1x10z7jffbgkg05w";
  };

  propagatedBuildInputs = [ adal argcomplete azure-cli-telemetry colorama
                            humanfriendly jmespath knack msrest msrestazure
                            paramiko pip pygments pyjwt pyopenssl pyyaml
                            requests six tabulate azure-mgmt-resource
                            azure-cli-nspkg antlr4-python3-runtime
                          ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Command-Line Tools Core Module";
    homepage = https://github.com/Azure/azure-cli;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
