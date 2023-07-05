#!/bin/bash

cleanDir() {
  if [ -d $1 ]; then
    echo "[ WAITING⌛ ]: Removing $1"
    rm -rf $1
    echo ""
    echo "[ SUCESS ✅ ]: Removed $1"
  else
    echo "[ ERROR 🥅 ]: $1 not exists"
  fi
}

cleanNestedDir() {
  if [ -d $1 ]; then
    echo "[ WAITING⌛ ]: Removing $1/**/$2"
    rm -rf $1/**/$2
    echo ""
    echo "[ SUCESS ✅ ]: Removed $1/**/$2"
  else
    echo "[ ERROR 🥅 ]: $1/**/$2 not exists"
  fi
}

cleanFile() {
  if [ -f $1 ]; then
    echo "[ WAITING⌛ ]: Removing $1"
    rm -rf $1
    echo ""
    echo "[ SUCESS ✅ ]: Removed $1"
  else
    echo "[ ERROR 🥅 ]: $1 not exists"
  fi
}

cleaEslintCache() {
  echo ""
  cleanFile .eslintcache
}

cleaCoverage() {
  echo ""
  cleanDir coverage
}

cleaDist() {
  if [ -d $1 ]; then
    echo ""
    cleanNestedDir $1 dist
  else
    echo ""
    cleanDir $1
  fi
}

cleanRootNM() {
  echo ""
  if [ -d "node_modules" ]; then
    echo "[ WAITING⌛ ]: Removing root node_modules"
    rm -rf node_modules
    echo ""
    echo "[ SUCESS ✅ ]: Removed root node_modules"
  else
    echo "[ ERROR 🥅 ]: Directory node_modules does not exists."
  fi
}

cleanNestedNM() {
  echo ""
  if [ -d $1 ]; then
    if [ -d "node_modules" ]; then
      echo "[ WAITING⌛ ]: Removing $1/**/node_modules"
      rm -rf $1/**/node_modules
      echo ""
      echo "[ SUCESS ✅ ]: Removed $1/**/node_modules"
    else
      echo "[ ERROR 🥅 ]: $1/node_modules does not exists."
    fi
  else
    echo "[ ERROR 🥅 ]: Directory $1 does not exists."
  fi
}

# Check the number of arguments
if [[ $# -eq 0 ]]; then
  echo "No arguments provided. Please provide at least one argument."
  exit 1
fi

# Process the arguments
for arg in "$@"; do
  # Skip arguments starting with a dot (.)
  if [[ $arg == .* ]]; then
    continue
  fi

  case $arg in
    -h|--help)
      echo "Help documentation:"
      echo "-h, --help: Display help information."
      echo "-v, --version: Display script version."
      echo "-c, --clean [name]: Clean unnecessery files."
      echo "-cnm, --clean-nm : Clean node_modules files."
      ;;
    -v|--version)
      echo "GRFT commander version 1.0"
      ;;
    -c|--clean)
      cleaDist
      cleaDist packages
      cleaCoverage
      cleaEslintCache
      shift # Skip the next argument
      ;;
    -cnm|--clean-nm)
      cleanRootNM
      cleanNestedNM packages
      shift # Skip the next argument
      ;;
    *)
      echo "Unknown argument: $arg"
      ;;
  esac
done

