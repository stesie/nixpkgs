{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-mgmt-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-mgmt-eventgrid";
  version = "0.4.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "1b49qxj6kmjmpr1m5dk30xwjk4vv7i7a358nv0h7wqjkwigij8ng";
  };

  propagatedBuildInputs = [
    azure-common
    azure-mgmt-nspkg
    msrestazure
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure EventGrid Management Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
