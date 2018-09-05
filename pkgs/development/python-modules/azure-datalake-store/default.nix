{ stdenv, buildPythonPackage, fetchPypi
, adal
, cffi
}:

buildPythonPackage rec {
  pname = "azure_datalake_store";
  version = "0.0.27";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    sha256 = "1h9073jzc2jm9lj345hx59y9rg4qp6fyislq1324hjy5vmvjpis2";
  };

  propagatedBuildInputs = [
    adal
    cffi
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Azure Data Lake Store Filesystem Client Library for Python";
    homepage = https://github.com/Azure/azure-data-lake-store-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
