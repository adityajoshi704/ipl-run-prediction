# IPL Run-Rate Prediction
Predicting IPL run rate using match phase and batting indicators.

**Objective**

To analyze and model run rate in IPL matches using match-phase and batting performance indicators, and to understand how factors such as wickets, boundary contribution, dot balls, and top-order dependency influence scoring momentum.

Run rate is used instead of total runs to improve stability, comparability across seasons, and interpretability.

**Data**

Seasons covered: IPL 2023, 2024, 2025

Unit of analysis: Team innings (winner and loser both included)

Source: ESPN Cricinfo (Statsguru)

**Key Variables**

Run_Rate: Runs per over (response variable)

PP_Wickets: Wickets lost in Powerplay overs

MO_Wickets: Wickets lost in Middle overs

Boundary_Count: Proportion of runs scored via boundaries

Top3_Proportion: Proportion of total runs scored by top 3 batters

DotBalls: Percentage of dot balls faced

**Methodology**

i)Feature Construction

Combined winner and loser innings across seasons

Created phase-wise and batting-composition indicators

ii)Exploratory Analysis

Paired comparisons between winning and losing teams

Distributional checks and hypothesis testing for key factors

iii)Modeling Approach

Multiple Linear Regression with Run Rate as the response

Additive model to retain interpretability

Stepwise selection (both directions) to balance fit and complexity

iv)Model Diagnostics

Residual analysis for linearity and homoscedasticity

Shapiro–Wilk test for residual normality

Durbin–Watson test for independence

Variance Inflation Factor (VIF) for multicollinearity

**Key Insights**

Dot ball percentage has a strong negative impact on run rate

Boundary contribution significantly boosts scoring momentum

Powerplay and middle-over wickets materially reduce run rate

Heavy reliance on top-order batters can be beneficial but introduces volatility

High-order interaction terms increased multicollinearity and were avoided in the final model

**Prediction Use Case**

The final model is used to:

Predict run rate for new match scenarios

Convert predicted run rate into projected 20-over totals

Generate prediction intervals to quantify uncertainty

This makes the model suitable for scenario analysis and match simulations.

**Limitations**

Some multicollinearity remains due to correlated batting indicators

Linear regression assumes constant variance and normality, which may be partially violated

Match context variables (venue, opposition strength, pitch conditions) are not included

These limitations provide scope for future refinement.

**Tools Used**

R

Packages: stats, car, lmtest

**Project Status**

Initial version completed.
Future improvements may include:

Regularization techniques (Ridge/Lasso)

Incorporation of contextual variables

Comparison with generalized linear or tree-based models
