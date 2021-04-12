library(pracma)
source('./R/plot_golden_angle_dist.R')

## Storing the different graphs:

# Even when programmed to run a vector of n_elements or displacement values, feel free to simply execute them.
# As long as 'save_file' = False, only the last array element will be rendered.

plot_golden_angle_dist(
    n_elements = c(1,2,3,4,5, 8, seq(10, 300, by = 3)),
    apply_x_spread = F,
    apply_y_spread = F,
    save_file = F,
    file_name_format = "fig/leaves_not_displaced/1_3_300-i_%03.0f_n_%03.0f.png")


plot_golden_angle_dist(
    n_elements = c(1,2,3,4,5, 8, seq(10, 300, by = 3)),
    apply_x_spread = F,
    apply_y_spread = F,
    draw_mode = 'bars',
    save_file = F,
    file_name_format = "fig/vert_bars_not_displaced/1_3_300-i_%03.0f_n_%03.0f.png")


plot_golden_angle_dist(
    n_elements = c(1,2,3,4,5, 8, seq(10, 300, by = 3)),
    save_file = F,
    file_name_format = "fig/leaves/1_3_300-i_%03.0f_n_%03.0f.png")


plot_golden_angle_dist(
    n_elements = c(1,2,3,4,5, 8, seq(10, 300, by = 3)),
    draw_mode = 'bars',
    save_file = F,
    file_name_format = "fig/vert_bars/1_3_300-i_%03.0f_n_%03.0f.png")


plot_golden_angle_dist(
    n_elements = 100,
    displacement = seq(-0.06, 0.06, length.out = 40),
    save_file = F,
    file_name_format = "fig/leaves_displacement/-06_006_06-i_%03.0f_n_%03.0f_d_%0.4f.png")


plot_golden_angle_dist(
    n_elements = 100,
    displacement = seq(-0.06, 0.06, length.out = 40),
    draw_mode = 'bars',
    save_file = F,
    file_name_format = "fig/vert_bars_displacement/-06_006_06-i_%03.0f_n_%03.0f_d_%0.4f.png")
