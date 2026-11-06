
# Monetary Theory EC 471/571 - Silicon Valley Bank Project
# Track C: Liquidity Assistance and New Capital
# Milestone 2: Progress Update Calculations

library(tidyverse)
# 1. Historical 10-K Data Analysis (Section 1 & 2 of Brief)
hist_data <- read.csv("input/data/raw/SVB_Historical_Data.csv", stringsAsFactors = FALSE)

get_val <- function(var_name, yr) {
  as.numeric(hist_data[hist_data$variable == var_name, yr])
}

# Key 2021 vs 2022 Historical Indicators
dep_2021 <- get_val("deposits", "X2021")
dep_2022 <- get_val("deposits", "X2022")
dep_growth <- (dep_2022 - dep_2021) / dep_2021

htm_net_2022 <- get_val("htm_carrying_net", "X2022")
htm_fair_2022 <- get_val("htm_fair", "X2022")
equity_total_2022 <- get_val("equity_total", "X2022")

htm_unrealized_loss_2022 <- htm_net_2022 - htm_fair_2022
htm_loss_equity_share_2022 <- (htm_unrealized_loss_2022 / equity_total_2022) * 100
adjusted_equity_2022 <- equity_total_2022 - htm_unrealized_loss_2022

cat("--- Historical SVB Highlights ---\n")
cat(sprintf("Deposit Growth (2021-2022): %.2f%%\n", dep_growth * 100))
cat(sprintf("2022 HTM Unrealized Loss: $%.3f B (%.2f%% of Total Equity)\n", 
            htm_unrealized_loss_2022, htm_loss_equity_share_2022))
cat(sprintf("2022 Partially Adjusted Equity: $%.3f B\n\n", adjusted_equity_2022))

# 2. Track C Simulation Model
# Baseline parameters
C <- 10.0; S0 <- 60.0; L <- 30.0; D <- 90.0; E0 <- 10.0
r0 <- 0.02; T_mat <- 5; delta_r <- 0.02
delta_sale <- 0.05; m_margin <- 0.10; new_eq_val <- 5.0; borrow_rate <- 0.05

# Portfolio revaluation
F_face <- S0 * ((1 + r0)^T_mat)
S1 <- F_face / ((1 + r0 + delta_r)^T_mat)
E_pre <- C + S1 + L - D

solve_scenario <- function(id, policy, W) {
  if (policy == "sale") { # CORE
    G <- max(0, W - C)
    cap <- C + S1 * (1 - delta_sale)
    x <- G / (1 - delta_sale)
    feasible <- (x <= S1)
    shortfall <- if (feasible) 0 else (W - cap)
    eq_close <- if (feasible) (E_pre - delta_sale * x) else NA
    borrowing <- 0; new_eq <- 0; interest <- NA
  } else if (policy == "market_collateral") {
    limit <- (1 - m_margin) * S1
    cap <- C + limit
    G <- max(0, W - C)
    feasible <- (G <= limit)
    shortfall <- if (feasible) 0 else (G - limit)
    borrowing <- min(G, limit)
    new_eq <- 0
    eq_close <- if (feasible) E_pre else NA
    interest <- if (feasible) (borrowing * borrow_rate) else NA
  } else if (policy == "par_collateral") {
    limit <- F_face
    cap <- C + limit
    G <- max(0, W - C)
    feasible <- (G <= limit)
    shortfall <- if (feasible) 0 else (G - limit)
    borrowing <- min(G, limit)
    new_eq <- 0
    eq_close <- if (feasible) E_pre else NA
    interest <- if (feasible) (borrowing * borrow_rate) else NA
  } else if (policy == "new_equity") {
    avail_cash <- C + new_eq_val
    G <- max(0, W - avail_cash)
    cap <- avail_cash + S1 * (1 - delta_sale)
    x <- G / (1 - delta_sale)
    feasible <- (x <= S1)
    shortfall <- if (feasible) 0 else (W - cap)
    eq_close <- if (feasible) (E_pre + new_eq_val - delta_sale * x) else NA
    borrowing <- 0; new_eq <- new_eq_val; interest <- NA
  }
  
  data.frame(
    Scenario = id, Policy = policy, Withdrawal = W,
    Capacity = round(cap, 2), Feasible = feasible,
    Shortfall = round(shortfall, 2),
    Borrowing = round(borrowing, 2),
    New_Equity = round(new_eq, 2),
    Closing_Equity = round(eq_close, 2),
    Annual_Interest = round(interest, 2)
  )
}

# Run CORE + Track C Scenarios
scenarios <- list(
  list("CORE", "sale", 30),
  list("C1", "market_collateral", 30),
  list("C2", "par_collateral", 30),
  list("C3", "new_equity", 30),
  list("C4", "market_collateral", 65),
  list("C5", "par_collateral", 65),
  list("C6", "new_equity", 65)
)

results <- do.call(rbind, lapply(scenarios, function(s) solve_scenario(s[[1]], s[[2]], s[[3]])))
cat("--- Track C Scenario Output Table ---\n")
print(results)