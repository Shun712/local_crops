// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap";
import '@fortawesome/fontawesome-free/js/all';
import "../stylesheets/application.scss";
import "../stylesheets/custom.scss";
import "../stylesheets/theme.scss";
import "../stylesheets/simplebar.scss";
import "../stylesheets/tiny-slider.scss";

require("jquery")
require("simplebar")
require("smooth-scroll")
require("tiny-slider")
require("prismjs")
require('./theme')

Rails.start()
ActiveStorage.start()
