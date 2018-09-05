{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-mgmt-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-mgmt-recoveryservices";
  version = "0.1.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "1vssmv6hyzz2ih5csjz7gyyk738vfb33wdlwf969yig2py7mp1xz";
  };

  propagatedBuildInputs = [ azure-common azure-mgmt-nspkg msrestazure ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Recovery Services Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
