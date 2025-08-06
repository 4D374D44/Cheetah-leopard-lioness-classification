# A MATLAB Fully Connected Neural Network Image Classifier Project
Date: June - 2022

This project implements a simple feedforward neural network with backpropagation in MATLAB. The model is trained and evaluated on a classification [dataset](https://www.kaggle.com/datasets/mbelalalkassab/cheetah-leopard-lioness-faces-colored-dataset) that contains three 
categories (cheetah, leopard, and lioness) each category has 40 colored 60x60 pixels pictures.

---

## Contents
- `Data_Prep.m`: Data preparation script that prepares the dataset by taking the pictures and saving them as gray-scale array of type double and outputs the file Out.mat.
- `Out.mat`: The processed dataset used, saved in variable DataN in the file 'Out.mat'.
- `Big_cat_classification.m`: Main MATLAB script for training, testing, and evaluating the neural network.
- Neural network features:
  - One hidden layer with a configurable number of neurons
  - Sigmoid activation function
  - Manual forward and backward pass (no MATLAB toolbox dependencies)
  - Accuracy computation using thresholding and categorization

---

## Features

- **Interactive parameter configuration**:
  - Input/output column selection
  - Test data percentage
  - Hidden layer size
  - Number of training iterations

- **Training**:
  - Random initialization of weights
  - Classic backpropagation with momentum
  - Per-epoch average error tracking

- **Testing**:
  - Forward pass with test data
  - Output error plotting
  - Categorical histogram of results (Cheeta, Leopard, Lioness, Faulty)

- **Accuracy Metric**:
  - Based on closeness of output to actual class value

---

## How to Run

1. **Open MATLAB**.
2. Make sure `Out.mat` and the main script are in the same directory.
3. Run the script:

   ```matlab
   Big_cat_classification.m
