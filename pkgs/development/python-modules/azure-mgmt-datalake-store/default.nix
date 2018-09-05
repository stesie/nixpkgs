{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-mgmt-datalake-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-mgmt-datalake-store";
  version = "0.2.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "1m0vn2mw5limh91a23n7s21mw568snb0lbqcsh94p0q0ivlwpp90";
  };

  propagatedBuildInputs = [
    azure-common
    azure-mgmt-datalake-nspkg
    msrestazure
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Data Lake Store Management Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
