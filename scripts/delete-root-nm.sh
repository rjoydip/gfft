#!/bin/bash

if [ -d "node_modules" ]
then
  echo "[WAIT ⌛]: Removing root node_modules directory"
  rm -rf node_modules
  echo "[SUCESS ✅]: Removed root node_modules directory"
  exit 1
else
  echo "[ERROR 🥅]: Directory 'node_modules' does not exists."
  exit 0
fi
