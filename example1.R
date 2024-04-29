library(neuralnet)
data(iris)
train_indices <- sample(1:nrow(iris), 0.7 * nrow(iris))
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
nn <- neuralnet(formula, data = train_data, hidden = c(5, 3), linear.output = FALSE)

# Make predictions on the testing data
predictions <- predict(nn, test_data)

# Convert predicted probabilities to class labels
predicted_classes <- colnames(predictions)[apply(predictions, 1, which.max)]

predicted_classes <- as.character(predicted_classes)

if (length(predicted_classes) == length(test_data$Species)) {
  # Evaluate the model's performance
  table(predicted_classes, test_data$Species)
} else {
 
  print("Error: The lengths of predicted_classes and test_data$Species do not match.")
}
