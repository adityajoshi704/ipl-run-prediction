############################################################
# IPL Run Rate Prediction
# Author: Aditya Joshi
#
# Description:
# This script analyzes how match-phase and batting indicators
# influence run rate in IPL matches and builds regression-
# based predictive models.
############################################################


# -------------------------------
# 1. Data Preparation
# -------------------------------

# Assumes IPL_2023, IPL_2024, IPL_2025 are already loaded

Run_Rate <- c(
  IPL_2023$`Run Rate1`, IPL_2023$`Run Rate2`,
  IPL_2024$`Run Rate1`, IPL_2024$`Run Rate2`,
  IPL_2025$`Run Rate1`, IPL_2025$`Run Rate2`
)

PP_Wickets <- c(
  IPL_2023$`PP Wickets`, IPL_2023$L2,
  IPL_2024$`PP Wickets`, IPL_2024$L2,
  IPL_2025$`PP Wickets`, IPL_2025$L2
)

MO_Wickets <- c(
  IPL_2023$`MO Wickets`, IPL_2023$L4,
  IPL_2024$`MO Wickets`, IPL_2024$L4,
  IPL_2025$`MO Wickets`, IPL_2025$L4
)

Boundary_Count <- c(
  IPL_2023$`Runs in BC%`, IPL_2023$L9,
  IPL_2024$`Runs in BC%`, IPL_2024$L9,
  IPL_2025$`Runs in BC%`, IPL_2025$L9
)

DotBalls <- c(
  IPL_2023$`Dot Balls%`, IPL_2023$L7,
  IPL_2024$`Dot Balls%`, IPL_2024$L7,
  IPL_2025$`Dot Balls%`, IPL_2025$L7
)

Top3_Proportion <- c(
  IPL_2023$P1, IPL_2023$P2,
  IPL_2024$P1, IPL_2024$P2,
  IPL_2025$P1, IPL_2025$P2
)

model_data <- data.frame(
  Run_Rate,
  PP_Wickets,
  MO_Wickets,
  Boundary_Count,
  DotBalls,
  Top3_Proportion
)


# -------------------------------
# 2. Exploratory Checks
# -------------------------------

summary(model_data)

# Relationship between dot balls and run rate
plot(DotBalls, Run_Rate,
     main = "Dot Ball Percentage vs Run Rate",
     xlab = "Dot Ball Percentage",
     ylab = "Run Rate")


# -------------------------------
# 3. Regression Model
# -------------------------------

# Null model
model_null <- lm(Run_Rate ~ 1, data = model_data)

# Full additive model (kept interpretable)
model_full <- lm(
  Run_Rate ~ PP_Wickets + MO_Wickets +
    Boundary_Count + Top3_Proportion + DotBalls,
  data = model_data
)

# Stepwise model selection
model_step <- step(model_full, direction = "both")

summary(model_step)


# -------------------------------
# 4. Model Diagnostics
# -------------------------------

library(car)
library(lmtest)

# Linearity & homoscedasticity
plot(model_step, which = 1)

# Normality of residuals
plot(model_step, which = 2)
shapiro.test(residuals(model_step))

# Independence of errors
durbinWatsonTest(model_step)

# Multicollinearity
vif(model_step)


# -------------------------------
# 5. Prediction Examples
# -------------------------------

new_matches <- data.frame(
  DotBalls = c(33, 49, 24, 28),
  PP_Wickets = c(2, 2, 3, 3),
  Top3_Proportion = c(0.31, 0.56, 0.15, 0.30),
  Boundary_Count = c(0.54, 0.47, 0.53, 0.57),
  MO_Wickets = c(5, 1, 1, 4)
)

predicted_rr <- predict(
  model_step,
  new_matches,
  interval = "prediction",
  level = 0.95
)

predicted_rr

# Convert run rate to projected 20-over total
predicted_rr * 20
