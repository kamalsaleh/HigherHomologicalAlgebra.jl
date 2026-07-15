## Show method: compile LaTeX output to PDF and open it

function Show( c::IsCapCategoryCell.abstract_type; scale = "1", width = "10in", height = "15in" )
    str = LaTeXOutput( c )
    if str !== fail
        Show( str; scale = scale, width = width, height = height )
    end
end

function Show( str::String; scale = "1", width = "10in", height = "15in" )
    
    # In a Jupyter notebook: render with MathJax via the text/latex MIME type
    if isdefined( Main, :IJulia )
        display( MIME"text/latex"(), "\\[$(str)\\]" )
        return
    end
    
    dir = mktempdir()
    filename = joinpath( dir, "main.tex" )
    
    latex_content = """
\\documentclass{article}
\\usepackage{geometry}
\\geometry{paperwidth=$(width), paperheight=$(height), margin=1in}
\\usepackage{mathtools}
\\usepackage{amssymb}
\\usepackage{amsthm}
\\usepackage{amsmath}
\\usepackage[dvipsnames]{xcolor}
\\setcounter{MaxMatrixCols}{100}
\\begin{document}
\\begin{center}
\\scalebox{$(scale)}{
\\($(str)\\)
}
\\end{center}
\\end{document}
"""
    
    write( filename, latex_content )
    
    cmd = Cmd( `pdflatex -interaction=nonstopmode -halt-on-error main.tex`; dir = dir )
    ret = run( ignorestatus( pipeline( cmd; stdout = devnull, stderr = devnull ) ) )
    
    if ret.exitcode != 0
        error( "pdflatex failed! Check the .tex file at: ", filename )
    end
    
    pdf = joinpath( dir, "main.pdf" )
    
    if Sys.islinux()
        run( `xdg-open $pdf`; wait = false )
    elseif Sys.isapple()
        run( `open $pdf`; wait = false )
    else
        println( pdf )
    end
    
end

export Show
