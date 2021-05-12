// $("#micropost_image").bind("change", function() {
// var size_in_megabytes = this.files[0].size/1024/1024;
// if (size_in_megabytes > 5) {
// alert("Maximum file size is 5MB. Please choose a smaller file.");
// $("#micropost_image").val("");
// }
// });
// $("#micropost_image").change(function() {
//   var extErrorMessage = "Only image file with extension: .jpeg, .gif or .png is allowed";
//   var allowedExtension = ["jpeg", "gif", "png"];

//   var extError = false;

//   var extName = $(this).val().split('.').pop().toLowerCase();
//     if ($.inArray(extName, allowedExtension) == -1) {extError=true;};

//   if (extError) {
//     alert(extErrorMessage);
//     $(this).val('');
//   };
// });

// $("#comment_image").bind("change", function() {
// var size_in_megabytes = this.files[0].size/1024/1024;
// if (size_in_megabytes > 5) {
// alert("Maximum file size is 5MB. Please choose a smaller file.");
// $("#comment_image").val("");
// }
// });
// $("#comment_image").change(function() {
//   var extErrorMessage = "Only image file with extension: .jpeg, .gif or .png is allowed";
//   var allowedExtension = ["jpeg", "gif", "png"];

//   var extError = false;

//   var extName = $(this).val().split('.').pop().toLowerCase();
//     if ($.inArray(extName, allowedExtension) == -1) {extError=true;};

//   if (extError) {
//     alert(extErrorMessage);
//     $(this).val('');
//   };
// });