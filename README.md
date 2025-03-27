# A-Share-Market-Comparison-and-Valuation-Signals

This project analyzes and compares key financial indicators of Chinese A-share listed companies between the Main Board and the Growth Enterprise Market (GEM) using firm-level data from the CSMAR database. The analysis spans the period from 2000 to 2023 and highlights cross-market structural differences, valuation levels, and potential trading implications.

## Project Objectives

- Compare valuation indicators (P/E, P/B) and firm characteristics between Main Board and GEM firms
- Track the time series of valuation metrics and highlight significant divergence
- Investigate return persistence and growth consistency across firms
- Suggest possible long-short ETF strategies based on market segment fundamentals

## Key Findings

- GEM firms tend to have higher P/E and P/B ratios, larger volatility, and higher R&D-to-asset ratios
- Firm age is lower on average for GEM, but median is higher due to survivorship bias
- Valuation divergence in September 2023: GEM traded at much higher multiples than the Main Board
- Suggested strategy: Long Main Board ETF (e.g., 510880), short GEM ETF (e.g., 159915)
- Low persistence in ROE and revenue growth: past performance is not a reliable indicator of future fundamentals

## Folder Structure

- `raw_data/`: Firm-level accounting and stock data from CSMAR
- `scripts/`: STATA do-file for data cleaning, merging, and metric construction
- `output/`: Final processed datasets and chart exports

## Tools Used

- STATA: data wrangling, financial ratio computation, and plotting
- Excel: visual support and comparison tables

## Notes

All analysis is based on publicly available datasets from CSMAR. The project is purely academic and does not constitute investment advice.
