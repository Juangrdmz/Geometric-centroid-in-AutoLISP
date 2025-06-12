;;Geometric centroid of a planar non-self-intersecting polygon using shoelace formula
;;     Last edited: 11/06/2025
;;     Work by: juangrdmz @ https://github.com/Juangrdmz/Geometric-centroid-in-AutoLISP
;;     source: https://mathworld.wolfram.com/PolygonCentroid.html

(defun c:CENTROID ( / geometry_selection geometry_data vertices_coordinates 
                     geometry_area shoelace_xsum shoelace_ysum shoelace_index 
                     X1 Y1 X2 Y2 centroid_x centroid_y centroid_coordinates)
(setq geometry_selection (car (entsel "Select planar non-self-inserting polygon:")))
  ;;generate DXF group codes values from geometry_selection.
(setq geometry_data (entget geometry_selection))
  ;;lambda "geometry_data" where car = 10 to get "vertices_coordinates"
(setq vertices_coordinates (mapcar 'cdr (vl-remove-if-not '(lambda (x) (= (car x) 10)) geometry_data)))
  ;;getvar needed because command "AREA" returns nill
(setq geometry_area (progn 
                      (command "AREA" "O" geometry_selection)
                      (getvar "AREA")))
(setq shoelace_xsum 0)
(setq shoelace_ysum 0)
  ;;i="shoelace index", a tool to count the loops
(setq shoelace_index 0)
  ;;shoelace formula compute for Σ(xi + xi+1)(xi*yi+1 - xi+1*yi)
(repeat (- (length vertices_coordinates) 1)
  (setq X1 (car (nth shoelace_index vertices_coordinates)))
  (setq Y1 (cadr (nth shoelace_index vertices_coordinates)))
  (setq X2 (car (nth (+ shoelace_index 1) vertices_coordinates)))
  (setq Y2 (cadr (nth (+ shoelace_index 1) vertices_coordinates)))
  ;;calculates (xi + xi+1)(xi*yi+1 - xi+1*yi) and adds up the result to shoelace_xsum
  (setq shoelace_xsum (+ shoelace_xsum (* (+ X1 X2) (- (* X1 Y2) (* X2 Y1)))))
  (setq shoelace_ysum (+ shoelace_ysum (* (+ Y1 Y2) (- (* X1 Y2) (* X2 Y1)))))
  (setq shoelace_index (+ shoelace_index 1))
  )
(setq centroid_x (/ shoelace_xsum (* 6 geometry_area)))
(setq centroid_y (/ shoelace_ysum (* 6 geometry_area)))
(setq centroid_coordinates (list centroid_x centroid_y))
(princ (strcat "\nCentroid coordinates: " (rtos centroid_x) ", " (rtos centroid_y)))
(princ "\n")
centroid_coordinates)