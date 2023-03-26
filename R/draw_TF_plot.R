draw_TF_plot <- function(df, prom_length = 1500, title = 'gene') {
  x_breaks_prom <- c(seq(-prom_length-500,400,300)[seq(-prom_length-500,400,300)!= 0])
  df |>
    dplyr::group_by(TF) |> # to group_by
    dplyr::mutate(height = dplyr::cur_group_id()) |> # to create column with same height for same TF
    ggplot2::ggplot(ggplot2::aes(x = height, group = TF, color = TF, fill = TF))+
    ggplot2::geom_rect(mapping=ggplot2::aes(xmin=rel_beg, xmax=rel_end,
                                            ymin=height, ymax=height-0.2),
                       alpha=0.5, show.legend = FALSE)+ # draw TF directly

    ggplot2::geom_text(ggplot2::aes(rel_beg-30, height-0.08, label = rel_beg), size = 2.5, color = 'black', show.legend = FALSE)+ # draw coordinate of beginning
    ggplot2::geom_text(ggplot2::aes(rel_end+30, height-0.08, label = rel_end), size = 2.5, color = 'black', show.legend = FALSE)+ # draw coordinate of ending
    ggplot2::geom_text(ggplot2::aes((rel_end+rel_beg)/2, height+0.5, label = TF), color = 'black',
                       size = 2.5, show.legend = FALSE)+ #draw TF label
    ggplot2::scale_x_continuous(name = 'promoter', limits = c(-1500-500,350),
                                breaks = c(x_breaks_prom,1),
                                labels = c(x_breaks_prom,'+1')
                                # sec.axis = dup_axis( name = paste0(c('genome coordinates',chr,':'),collapse = ' '),
                                #                      labels = x_breaks_gc)
    )+

    ggplot2::scale_y_continuous(limits = c(-0.5,(nrow(df)+1+1)), expand = c(0,0))+
    ggplot2::theme_classic()+
    ggplot2::ggtitle(title)+
    # draw arrow as TSS
    ggplot2::geom_segment(ggplot2::aes(x = 1, y = -0.5, xend = 1, yend = 1), color = 'black')+
    ggplot2::geom_segment(ggplot2::aes(x = 1, y = 1, xend = 100, yend = 1), arrow = ggplot2::arrow(length = ggplot2::unit(0.02,units = "npc")),
                          size = 0.8, color = 'black')+
    ggplot2::geom_text(ggplot2::aes(20, 2.1, label = 'TSS'), color = 'black', size = 3)+
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = 'italic'),
                   axis.title.y=ggplot2::element_blank(),
                   axis.text.y=ggplot2::element_blank(),
                   axis.ticks.y=ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank())
  # plot_sample  <- renderPlot({  data$sample_plot })
}
# ein3 <- vroom::vroom('data/template.txt', delim = "\t", col_names = c('TF', 'rel_beg', 'rel_end'))
# draw_TF_plot(ein3)
# x_breaks_prom <- reactive(c(seq(-input$prom_length-500,400,300)[seq(-input$prom_length-500,400,300)!= 0]))