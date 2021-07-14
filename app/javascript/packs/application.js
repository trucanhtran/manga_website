// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("jquery");

function displayChapter(data){
  document.getElementById("id_chapter_content").innerHTML = "";
  const arrImage =data.image_list.split(",")
  for (let i=0 ; i < arrImage.length; i++){
    var node = document.createElement("img");
    node.setAttribute("src", arrImage[i]);
    node.setAttribute("loading", "auto");
    document.getElementById("id_chapter_content").appendChild(node);
  }
}

function changeTitle(data){
  $("#id_chapter_title").text(data.title)

}

function handleDisplayComment(data){
  var node = document.createElement("div");
  var textNode = document.createTextNode(data);
  node.appendChild(textNode);
  document.getElementById("id_list_comment").appendChild(node);
}

$(document).ready(function(){
  $(document).on("change", "#chapter_id", function(event){
    $.post("/change_chapter",{chapter_id: event.target.value } ,function(data, status){
      displayChapter(data);
      changeTitle(data);
    });
  });
  $(document).on("click", "#id_send_comment", function(){
    const content = $("#id_comment").value
    $.post("/create_comment", {content: content}, function(data, status){
      handleDisplayComment(data);
    });
  })
});
