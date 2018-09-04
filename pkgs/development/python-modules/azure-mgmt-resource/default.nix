{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-mgmt-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-mgmt-resource";
  version = "2.0.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "0zwda6jqv018qmjaxajnz5873vfllysqs4cjczqd125yd69ji0rf";
  };

  propagatedBuildInputs = [ azure-common azure-mgmt-nspkg msrestazure ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Resource Management Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ olcai stesie ];
  };
}
