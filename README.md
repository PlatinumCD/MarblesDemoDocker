# SST Docker Demo

This project is a demonstration of the SST (Structural Simulation Toolkit) simulator using a Docker container. The Makefile provided allows you to build, run, and clean up the Docker image for the simulation.

This image uses the following repositories:
  - **SST Core**
    - **Repo**: [https://github.com/sstsimulator/sst-core.git](https://github.com/sstsimulator/sst-core.git)
    - **Branch**: `v14.0.0_Final`

  - **SST Elements**
    - **Repo**: [https://github.com/PlatinumCD/lightweight-sst-elements](https://github.com/PlatinumCD/lightweight-sst-elements)
    - **Branch**: `master`

  - **Custom SST Element**
    - **Repo**: [https://github.com/PlatinumCD/MarblesDemo.git](https://github.com/PlatinumCD/MarblesDemo.git)
    - **Branch**: `master`

## Makefile Targets

- **build**: Builds the Docker image for the SST simulator. It uses the `BUILD_SRC` and `BUILD_DEST` arguments to specify the source and destination directories within the Docker image.

- **run**: Runs the Docker container and executes the SST simulation using the `test_simulation.py` script located in the specified source directory.

- **clean**: Removes the Docker image created by the `build` target.

## Usage

1. **Build the Docker Image**: 
   ```bash
   make build
   ```

2. **Run the Simulation**:
   ```bash
   make run
   ```

3. **Clean Up**:
   ```bash
   make clean
   ```

