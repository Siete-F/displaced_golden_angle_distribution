
plot_golden_angle_dist <- function(
    canvas_w = 360, canvas_h = 150, 
    leave_size = 0.1, n_elements = 100, displacement = 0.02,
    apply_x_spread = T, apply_y_spread = T,
    draw_mode = 'leaves', save_file = F, file_name_format = NULL) {
    
    # If the outcomes are not saved, there is no use in plotting intermediate results.
    if (!save_file) {
        n_elements   <- n_elements[length(n_elements)]
        displacement <- displacement[length(displacement)]
    }
    
    ## A constant of the Golden Angle:
    G_ANGLE <- 137.507764 # An approximation ;)
    
    ## Loop through 1 or multiple "displacement" and "nr of elements" values:
    index = 0
    for (displace in displacement) {
        for (n_elem in n_elements) {
            index <- index + 1
            
            # First create in "loc" the series of golden angles on a 360 deg range:
            loc <- 0
            for (iAngle in seq_len(n_elem)) {
                prev_loc <- loc[length(loc)]
                # "%%" calculates the remainder.
                loc <- c(loc, (prev_loc + G_ANGLE) %% 360)
            }
            
            # Append a 'Y' axis:
            y_val <- seq(from = 0, to = canvas_h, length.out = n_elem+1)
            loc_d <- data.frame(x = loc/360*canvas_w, y = y_val)
            
            
            # Apply X displacement:
            if (apply_x_spread) {
                
                displacement_vecX <- interp1(x = c(0, 0.05, 0.5, 0.95, 1) * canvas_w,
                                             y = c(0, -displace, 0, displace, 0) * canvas_w, # <- The correction factor, will increase by 30% when spline is used
                                             xi = loc_d$x,
                                             method = 'spline')
                
                loc_d$x <- loc_d$x + displacement_vecX
            }
            
            # Apply Y displacement:
            if (apply_y_spread) {
                
                displacement_vecY <- interp1(x = c(0, 0.05, 0.5, 0.95, 1) * canvas_h, # X is actually Y, and y=X
                                             y = c(0, -displace, 0, displace, 0) * canvas_h, # <- The correction factor, will increase by 30% when spline is used
                                             xi = loc_d$y,
                                             method = 'spline')
                
                loc_d$y <- loc_d$y + displacement_vecY
            }
            
            
            # Plot (and save) the data:
            if (save_file) {
                png(filename = sprintf(file_name_format, index, n_elem, displace),
                    width = 600, height = 350, units = "px", bg = "transparent")
            }
            # "par(xpd = TRUE)" Allows plotting outside of plotting region:
            
            
            # Plot it, in case of 'no' data, it will set the canvas, ranges and labels anyway.
            type <- switch (draw_mode,
                            leaves = {par(xpd = TRUE); 'n'}, # means 'no'
                            bars   = 'h',
                            points = 'p',
            )
            
            plot(loc_d,
                 xlim = c(0, canvas_w), ylim = c(0, canvas_h),
                 xaxt = "n", yaxt = "n",  # hide axis, I create a custom one below
                 type = type,    # n = no, h = vertical lines, p = points
                 asp = 1,        # The aspect ratio, 1 is equal axis.
                 xlab = "angle", ylab = "")
            
            axis(side = 1, at = seq(0, 360, by = 90), labels = T)
            
            # Draw leaves at co?rdinates:
            if (draw_mode == 'leaves') {
                # The leave is drawn on paper and below, x and y, represent it's digital equivalent :) no magic here
                # The "scale" value makes the 'leave_size' (actually the length) relative to the canvas_w value.
                # So in short, leave_size is the ratio of canvas with.
                scale <- canvas_w * leave_size / 100
                leave <- data.frame(
                    x = c(3, 3, 26,  37,  39,  34,  26,  11,    0, -11, -26, -34, -39, -37, -26, -3, -3) * scale,
                    y = c(5, 0, -9, -21, -39, -56, -71, -86, -100, -86, -71, -56, -39, -21,  -9,  0,  5) * scale)
                
                for (iLeave in seq_len(nrow(loc_d))) {
                    polygon(x = leave$x + loc_d[iLeave, 'x'], 
                            y = leave$y + loc_d[iLeave, 'y'], 
                            col = rgb(0.6, 0.7, 0.9, 1), border = T)
                }
            }
            
            if (save_file) {
                dev.off()
            }
        }
    }
}
