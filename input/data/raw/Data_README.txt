SVB GROUP PROJECT DATA
Monetary Theory EC 471/571

Start with SVB_Project_Brief.pdf and SVB_Case_Dossier.pdf.
Choose Excel, R or Python. The workbook and the three CSV files contain the
same input records. You do not have to use both formats. No download or
commercial data subscription is required.

FILES
SVB_Project_Data.xlsx: three input sheets with definitions and units.
SVB_Historical_Data.csv: 17 variables, with values for 2021 and 2022.
Model_Assumptions.csv: 14 constructed parameters and their meanings.
Scenario_Inputs.csv: CORE plus six rows for each of tracks A, B and C.

Complete CORE and your chosen track only. Calculate answers in your own
spreadsheet area or script. Preserve the original input records. Keep a
readable path from inputs to results; pasted final numbers alone do not show
how an answer was obtained.

HISTORICAL DATA
Entity: SVB Financial Group, consolidated, not the bank subsidiary alone.
Reporting dates: December 31, 2021 and December 31, 2022.
Unit: USD billions. Source amounts in USD millions are divided by 1,000.
Source: 2022 Form 10-K, Consolidated Balance Sheets, printed page 95.
https://www.sec.gov/Archives/edgar/data/719739/000071973923000021/sivb-20221231.htm
Filed February 24, 2023. Source checked September 24, 2026.

The variable column is a stable code. The label and definition columns are
the data dictionary. Each year column refers to that December 31.
other_assets_residual and other_liabilities_residual are calculated by
subtraction as their definitions specify; the other numeric inputs are
reported values or disclosures in the source balance sheet.

htm_fair is a disclosed alternative valuation of the same HTM portfolio.
Do not add it as an extra asset. htm_carrying_net already deducts the
htm_credit_allowance. Total equity equals equity_parent + noncontrolling.
Interest-bearing deposits are not the same category as uninsured deposits.

MODEL INPUTS
These are teaching assumptions, not historical estimates. Initial assets
are 100 arbitrary monetary units. Rates and fractions are decimal numbers:
0.02 is 2 percent as a yield or 2 percentage points as a yield change.
The unit and meaning columns distinguish amounts, years and rates.
Sale discount is an extra discount from current fair value, after the
interest-rate shock. Securities used as collateral remain assets of the
borrower; the loan creates a liability.

SCENARIO FIELDS
scenario_id: CORE, A1-A6, B1-B6 or C1-C6.
track: Core, A, B or C. Do not solve the two unchosen tracks.
maturity_years: remaining years at the instant of the rate shock.
rate_shock: change added to the common initial yield, with no time elapsed.
withdrawal: model units requested. Blank for B because you calculate it.
uninsured_share: fraction of initial deposits classified as uninsured, u.
uninsured_withdrawal_fraction: fraction of that segment withdrawn, alpha.
insured_withdrawal_fraction: fraction of the other segment withdrawn, beta.
policy: sale, market_collateral, par_collateral or new_equity.

Other blank scenario cells mean not applicable, not a numeric zero or
missing historical observation. The readable Excel headers may abbreviate
these field names. Scenario IDs provide the same row identifiers in both
formats. Parameters not changed by a scenario retain the common values.

RESULTS TO RETAIN
For CORE and your track: securities value, equity before withdrawals,
funding capacity, payment feasibility, cash shortfall, and equity after
full payment if feasible. Keep the intermediate steps and closing balance
requested in the brief. Tracks A and B also need the fair value sold and
additional sale loss. B needs the critical uninsured withdrawal fraction.
C needs borrowing capacity, actual new borrowing, new equity and the
separate annual-interest calculation for fully funded loan cases.

If full payment is infeasible, report the shortfall and leave that
full-payment closing balance unavailable. A cash capacity is not a claim
that the bank is solvent or legally permitted to continue operating.

IMPORT AND SUBMISSION
CSVs are UTF-8 with comma separators and period decimal marks. Import year
value columns and model inputs as numeric data. In R, read.csv can rename
year headers to X2021 and X2022; check.names=FALSE preserves the original
headers. In Python, DictReader reads text: convert numeric fields explicitly
and handle blank scenario cells according to the definitions above.

Excel users can open the supplied XLSX directly. Save your completed
workbook separately, retaining formulas. R/Python users should submit input
CSVs and code with a short run instruction and any package requirements.
Use relative paths where practical. No specific package is required.
Round only final displayed results to two decimals; retain full precision
in calculations. Report units, sources, contributions and any AI help.
