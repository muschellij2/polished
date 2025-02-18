% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_03_app_users.R
\name{add_app_user}
\alias{add_app_user}
\title{Polished API - Add a User to an App}
\usage{
add_app_user(
  app_uid,
  user_uid = NULL,
  email = NULL,
  is_admin = FALSE,
  send_invite_email = FALSE,
  api_key = get_api_key()
)
}
\arguments{
\item{app_uid}{the app uid.}

\item{user_uid}{an optional user uid for the user to be invited to the app.}

\item{email}{an optional email address for the user to be invited to the app.}

\item{is_admin}{boolean (default: \code{FALSE}) - whether or not the user is a Polished admin.}

\item{send_invite_email}{boolean - whether or not to send the user an invite email
notifying them they have been invited to access the app.}

\item{api_key}{your Polished API key.  Set your polished api key using \code{\link{set_api_key}()}
so that you do not need to supply this argument with each function call.}
}
\description{
Polished API - Add a User to an App
}
\details{
supply either the \code{user_uid} or \code{email}. If both are provided, then
the \code{user_uid} will be used, and the \code{email} will be ignored.
}
\seealso{
\code{\link[=get_app_users]{get_app_users()}} \code{\link[=update_app_user]{update_app_user()}} \code{\link[=delete_app_user]{delete_app_user()}}
}
