# BMTK Test Network

A comprehensive BMTK (Brain Modeling Toolkit) neural network simulation for testing and demonstrating cortical microcircuit dynamics. This repository provides a complete working example of biophysical neural network modeling using the BMTK framework with NEURON simulator backend.

## 🧠 Overview

This project implements a simplified cortical microcircuit model featuring:
- **200 Excitatory neurons** (RTM model - Reduced Traub-Miles)
- **50 Parvalbumin-positive (PV) interneurons** (Wang-Buzsáki model)
- **50 Somatostatin-positive (SOM) interneurons** (Wang-Buzsáki model)
- **Stochastic background input** via Poisson spike trains
- **Realistic synaptic dynamics** with short-term plasticity

The network is designed as a reference implementation for BMTK workflows, featuring proper configuration management, biophysical modeling, and analysis pipelines.

## 📁 Repository Structure

### Core Files
- **`build_network.ipynb`** - Jupyter notebook for network construction and connectivity
- **`run_network.py`** - Main simulation execution script
- **`analysis.ipynb`** - Post-simulation analysis and visualization
- **`synapses.py`** - Custom synapse models and weight functions

### Configuration Files
- **`circuit_config.json`** - Network topology and component specifications
- **`simulation_config.json`** - Simulation parameters and runtime settings
- **`node_sets.json`** - Node group definitions for targeting specific populations
- **`submit_run.sh`** - SLURM batch script for HPC execution

### Network Data (`network/`)
Generated network files in SONATA format:
- `*_nodes.h5` / `*_node_types.csv` - Node definitions and properties
- `*_edges.h5` / `*_edge_types.csv` - Connectivity matrices and synaptic parameters

### Components (`components/`)
#### Biophysical Models
- **`biophysical_neuron_models/`** - Neuron parameter files (e.g., `472363762_fit.json`)
- **`morphologies/`** - Cell morphology files (`blank.swc` for point neurons)
- **`templates/`** - HOC template files for cell types (`templates_V1.hoc`)

#### Synaptic Models
- **`synaptic_models/synapses_simple/`** - JSON files defining synaptic parameters:
  - `Exc2Exc.json`, `Exc2PV.json`, `Exc2SOM.json` - Excitatory connections
  - `PV2Exc.json`, `PV2PV.json` - PV interneuron connections  
  - `SOM2Exc.json`, `SOM2PV.json` - SOM interneuron connections
  - `background_syn.json` - Background noise synapses

#### NEURON Mechanisms (`mechanisms/`)
- **`modfiles/`** - NEURON MOD files for ion channels and synapses
- **`x86_64/`** - Compiled mechanism files (.c, .o)
- Key mechanisms: `AMPA_NMDA_STP.mod`, `GABA_A_STP.mod`, `exp2syn_stp.mod`

### Input/Output
- **`input/ext_inp_poisson.h5`** - External Poisson spike trains
- **`output/`** - Simulation results (spikes, logs)

## 🚀 Quick Start

### 1. Environment Setup
Ensure you have BMTK, NEURON, and required Python packages installed:
```bash
pip install bmtk neuron matplotlib numpy pandas bmtool
```

### 2. Build the Network
Run the network construction notebook:
```bash
jupyter notebook build_network.ipynb 
```
You can also pull it up in VS code.
This creates the network topology, connectivity patterns, and external inputs.

### 3. Run Simulation
Execute the simulation single core:
```bash
python run_network.py simulation_config.json
```

For HPC environments for multi-core runs:
```bash
sbatch submit_run.sh
```

### 4. Analyze Results
Open the analysis notebook to visualize results:
```bash
jupyter notebook analysis.ipynb
```

## 🔧 Key Features

### Network Architecture
- **E/I Balance**: 4:1 ratio of excitatory to inhibitory neurons
- **Spatial Organization**: 3D cubic arrangement with minimum distance constraints
- **Cell Types**: 
  - Excitatory: RTM (Reduced Traub-Miles) model
  - PV Interneurons: Wang-Buzsáki fast-spiking model
  - SOM Interneurons: Wang-Buzsáki model with different parameters

### Connectivity Patterns
- **E→E**: 0% (no recurrent excitation)
- **E→I**: 100% connectivity (strong feedforward inhibition)
- **I→E**: 100% connectivity (feedback inhibition)  
- **I→I**: Variable connectivity with cell-type specific rules

### Synaptic Dynamics
- **AMPA/NMDA**: Excitatory synapses with short-term plasticity
- **GABA-A**: Inhibitory synapses
- **Background**: Poisson noise at 60 Hz per excitatory cell

### Analysis Tools
- **Spike raster plots**: Population activity visualization
- **Firing rate analysis**: Population and single-cell statistics
- **Network statistics**: Connectivity and weight distributions

## ⚙️ Customization

### Modifying Network Size
Edit `build_network.ipynb`:
```python
n_E = 200  # Number of excitatory cells
n_I = 50   # Number of inhibitory cells
```

### Adjusting Connectivity
Modify connection probabilities:
```python
p_EI = 1.0  # E→I connection probability
p_IE = 1.0  # I→E connection probability
```

### Changing Simulation Duration
Edit `simulation_config.json`:
```json
{
  "run": {
    "tstop": 1000.0,  # Simulation time (ms)
    "dt": 0.1         # Time step (ms)
  }
}
```

## 📊 Expected Results

The network typically exhibits:
- **Sparse firing**: ~1-10 Hz average firing rates
- **Balanced dynamics**: Irregular, asynchronous activity
- **Cell-type differences**: PV cells fire more regularly than SOM cells
- **Network oscillations**: Possible gamma-range activity (30-80 Hz)

## 🛠️ Dependencies

- **BMTK** (Brain Modeling Toolkit)
- **NEURON** (Neural simulation environment)
- **Python 3.7+** with standard scientific packages
- **HDF5** support for data I/O
- **MPI** (for parallel simulations)

## 📝 Notes

- This is a **reference implementation** - modify parameters as needed
- Compatible with both **local** and **HPC** environments

## 🔗 Related Resources

- [BMTK Documentation](https://alleninstitute.github.io/bmtk/)
- [NEURON Documentation](https://www.neuron.yale.edu/neuron/)
- [SONATA Data Format](https://github.com/AllenInstitute/sonata)

---

*This network serves as a foundation for testing BMTK workflows and can be extended for more complex cortical modeling studies.*
