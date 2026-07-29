function HorizontalRule()
	return pandoc.RawBlock("latex", "\\begin{center}\\rule{\\textwidth}{0.5pt}\\end{center}")
end
