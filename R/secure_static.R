#' Secure a static HTML page
#'
#' \code{secure_static()} can be used to secure any HTML
#' page using \code{polished}.  It is often used to add \code{polished} to \code{.Rmd} htmloutput
#' and flexdashboards.
#'
#' @param html_file_path the path the to HTML file.  See the details for more info.
#' @param polished_config_args arguments to be passed to \code{\link{polished_config}}.
#' @param sign_out_button action button or link with \code{inputId = "sign_out"}. Set to \code{NULL} to not include a sign out button.
#'
#' @md
#'
#' @details To secure a static HTML page, place the HTML page in a folder named "www"
#' and call \code{secure_static()} from a file named \code{app.R}.  The file structure should
#' look like:
#'
#' - app.R
#' - www/
#'   - index.html
#'
#' @noRd
#'
#' @return a Shiny app object
#'
#' @importFrom shiny shinyApp actionButton actionLink icon observeEvent
#' @importFrom htmltools tags tagList
#'
secure_static <- function(
  html_file_path,
  polished_config_args,
  sign_out_button = shiny::actionLink(
    "sign_out",
    "Sign Out",
    icon = shiny::icon("sign-out-alt"),
    class = "polished_sign_out_link"
  )) {

  ui <- htmltools::tagList(
    sign_out_button,
    tags$head(
      tags$style("
      body {
        margin: 0;
        padding: 0;
        overflow: hidden
      }

      .polished_sign_out_link {
        font-family: 'Source Sans Pro',Calibri,Candara,Arial,sans-serif;
        position: absolute;
        top: 0;
        right: 15px;
        color: #FFFFFF;
        z-index: 9999;
        padding: 15px;
        text-decoration: none;
      }
    "),
    ),
    tags$iframe(
      src = html_file_path,
      height = "100%",
      width = "100%",
      style="height: 100%; width: 100%; overflow: hidden; position: absolute; top:0; left: 0; right: 0; bottom:0",
      frameborder="0"
    )
  )

  ui_out <- secure_ui(
    ui,
    custom_admin_button_ui = shiny::actionButton(
      "polished-go_to_admin_panel",
      "Admin Panel",
      icon = shiny::icon("cog"),
      style = "position: fixed; bottom: 15px; right: 15px; color: #FFFFFF; z-index: 9999; background-color: #0000FF; padding: 15px;"
    )
  )

  server <- secure_server(function(input, output, session) {

    shiny::observeEvent(input$sign_out, {

      tryCatch({
        sign_out_from_shiny(session)
        session$reload()
      }, error = function(err) {
        print(err)
      })

    })
  })


  shiny::shinyApp(ui_out, server, onStart = function() {
    library(polished)

    # configure the global sessions when the app initially starts up.
    do.call(
      "polished_config",
      polished_config_args
    )
  })
}
