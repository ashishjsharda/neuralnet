library(neuralnet)
library(MASS)  
data(Boston)


# Split the data into training and testing sets
sample_size <- floor(0.8 * nrow(Boston))
set.seed(456) # Set a seed for reproducibility
train_ind <- sample(seq_len(nrow(Boston)), size = sample_size)
train_data <- Boston[train_ind, ]
test_data <- Boston[-train_ind, ]

# Build the neural network model
model <- neuralnet(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat,
                   data = train_data,
                   hidden = 5, 
                   act.fct = 
                   linear.output = TRUE) # Output is linear (for regression)

# Print the model summary
print(model)


predictions <- compute(model, test_data[, 1:13])
predicted_values <- predictions$net.result

rmse <- sqrt(mean((predicted_values - test_data$medv)^2))
print(paste("RMSE on test set:", rmse))
