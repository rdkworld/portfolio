## README.md

Steps to upload to PyPi.org

1. Add 3 files within folder insider the package - README.md, setup.cfg and license.txt. In setup.cfg file, name and packages should match
2. Rename the package folder to match name and packages in setup.cfg file
3. Type python setup.py sdist
4. You will see two additional folders getting created dist and <package name>.egg-info folder. Within dist, there will be tar.gz file
5. Type pip install twine

# Install to test.pypi.org
6. twine upload --repository-url https://test.pypi.org/legacy/ dist/*
7. Enter test.pypi.org username and password
8. Login online to test.pypi.org and check if your package has been uploaded
9. Uninstall package first using pip uninstall <package-name> to test
10. pip install --index-url https://test.pypi.org/simple/ <package-name>  
  

# Install to pypi.org
11. twine upload dist/*
12. Enter pypi.org username and password
13. Login online to pypi.org and check if your package has been uploaded
14. Uninstall package first using pip uninstall <package-name> to test
15. pip install distributions

# Pypi converts _ to -. So, when pip installing, use - (dash) and when using python terminal or in program, use _.
