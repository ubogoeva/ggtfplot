test_that("is input dataset correct?", {
  test_df <- data.frame(
    TF = c("TF1", "TF2", "TF3"),
    rel_beg = c(-1000, -700, -400),
    rel_end = c(-800, -450, -300),
    extra_column = 1
  )
  expect_warning(draw_TF_plot(test_df), "Dataset contain more than 3 column")
  expect_error(draw_TF_plot(test_df[, 1:2]), "Dataset contain less than three")
  expect_error(draw_TF_plot(1:10), 'Dataset must be data.frame')
})
