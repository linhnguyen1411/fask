// $(document).ready(function(){
//   var username = '';
//   var suggest_users = false;
//   $('.suggest_users').keypress(function(event){
//     if (suggest_users) {
//       username = username + String.fromCharCode(event.charCode);
//       $.ajax({
//         url: '/suggest_tags',
//         data: { key: username },
//         success: function (data) {
//           $( "#suggest_users" ).autocomplete({
//             source: data.data
//           });
//         },
//         error: function () {
//           response([]);
//         }
//       });
//     }
//     if(String.fromCharCode(event.charCode) == '@'){
//       suggest_users = true
//     }
//   });
// });
