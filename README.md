This AutoLISP routine adds the function "CENTROID" wich via entity selection by user gathers
its vertices coordinates and computes the formulas:

x̄ = (1/6A) Σ(i=1 to n) (xᵢ + xᵢ₊₁)(xᵢyᵢ₊₁ - xᵢ₊₁yᵢ) For X coordinates of the centroid and

ȳ = (1/6A) Σ(i=1 to n) (yᵢ + yᵢ₊₁)(xᵢyᵢ₊₁ - xᵢ₊₁yᵢ) for Y coordinates

To use the routine first execute the command "APPLOAD" and upload "geometric_centroid.lsp"
after this, the command "CENTROID" should be avaliable in your AutoCAD drawing file.
