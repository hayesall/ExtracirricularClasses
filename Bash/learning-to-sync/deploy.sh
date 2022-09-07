#!/usr/bin/env bash

# Deploy the `demo-directory` to a remote server using rsync
rsync -av --delete demo-directory/ hayesall@tank.luddy.indiana.edu:/u/hayesall/demo-directory/
