//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

'use strict';



$(document).on('turbolinks:load', function(){

// ------------------------------------------ navbar ------------------------------------------ //
  $('#user-nav-pc li a').each(function(){
    var $href = $(this).attr('href');
    if(location.href.match($href)) {
      $(this).addClass('active');
      } else {
        $(this).removeClass('active');
      }
  });
  
  $('#user-nav-sp li a').each(function(){
    var $href = $(this).attr('href');
    if(location.href.match($href)) {
      $(this).addClass('active');
    } else {
      $(this).removeClass('active');
    }
  });

// ------------------------------------------ .flash ------------------------------------------ //
  $('.flash').fadeOut(4000);
});


// ------------------------------------------ maps/index ------------------------------------------ //
function initMap() {
  'use strict';

  let target = document.getElementById('target');
  var geocoder = new google.maps.Geocoder();
  let map;
  let tokyo = {lat: 35.681167, lng: 139.767052};
  let service;
  let circle;
  let infoWindow;
  
  map = new google.maps.Map(target, {
    center: tokyo,
    zoom: 15
  });

  // 現在地から検索
  document.getElementById('search').addEventListener('click', function() {
    let resultRow = document.getElementById('result-row');
    if (!navigator.geolocation) {
      alert('Geolocation not supported');
      return;
    }
    
    // 位置情報を取得する
    navigator.geolocation.getCurrentPosition(function(position) {
      // 現在地の緯度軽度取得
      resultRow.innerHTML = ""
      let latitude = position.coords.latitude;
      let longitude = position.coords.longitude;
      alert('緯度:' + latitude + ' / 経度:' + longitude);
      let latlng = new google.maps.LatLng(latitude, longitude);
      
      // 現在地の緯度軽度を中心にマップ生成
      map = new google.maps.Map(target, {
        center: {
          lat: latitude,
          lng: longitude
        },
        zoom: 13
      });

      // 現在地から2.5kmの円を描く
        let circleOptions = {
          map: map,
          center: new google.maps.LatLng(latitude, longitude),
          radius: 5000,
          strokeColor: '#bcddff',
          strokeOpacity: 1,
          strokeWeight: 1,
          fillColor: '#bcddff',
          fillOpacity: 0.35
        };
        circle = new google.maps.Circle(circleOptions);


      // 現在地から5km以内のアクアショップを検索
      infoWindow = new google.maps.InfoWindow();
      service = new google.maps.places.PlacesService(map);
      service.nearbySearch({
        location: latlng,
        radius: 5000,
        type: ['pet_store'],
        keyword: ['熱帯魚', '淡水魚', '海水魚']
      }, function (results, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          for (let i = 0; i < results.length; i++) {
            // 地図上にマーカーを設置
            createMarker(results[i]);

            // 店舗詳細表示
            service.getDetails({
              placeId: results[i].place_id 
            }, function(place) {
              
              let setPhoto_1 = place.photos[0].getUrl({"maxWidth":200,"maxHeight":300});
              let setPhoto_2 = place.photos[1].getUrl({"maxWidth":200,"maxHeight":300});
              
              resultRow.insertAdjacentHTML('afterbegin',  
                `<div class='result-box col-lg-5 border shadow p-3 mb-5 bg-white rounded'>
                  <ul class='result-content'>
                    <li class='store_name text-primary border-bottom mb-2'>${place.name}</li>
                    <li class='store_address'>${place.formatted_address}</li>
                    <li>総合評価: <i class="fas fa-star text-warning"></i><span>${place.rating}</span></li>
                    <li>クチコミ件数: <span>${place.user_ratings_total}</span>件</li>
                  </ul>
                  <div class='shop-images'>
                    <a href="${place.website}" target="_blank" rel="noopener noreferrer">
                      <img src='${setPhoto_1}' class='shop-image me-1'>
                      <img src=${setPhoto_2} class='shop-image'>
                    </a>
                  </div>
                </div>`
              );
            });
          }
        }
        
        // マーカーをクリックした際の動作
        function createMarker(place) {
          let placeLoc = place.geometry.location;
          let marker = new google.maps.Marker({
            map: map,
            position: placeLoc
        });
        // ウィンドウの中身
        google.maps.event.addListener(marker, 'click', function() {
          infoWindow.setContent(
            '<div><strong>' + place.name +'<strong><br>' + '評価 ' + place.rating + '</div>' +
            '<img class="shop-image" src=' + place.photos[0].getUrl({"maxWidth":300,"maxHeight":300}) + '>'
          );
          infoWindow.open(map, this);
        });
        }
      }, function() {
        alert('Geolocation failed!');
        return;
      });
    });
  });


  // 住所指定での検索
  document.getElementById('addressSearch').addEventListener('click', function() {
    geocoder.geocode({
      address: document.getElementById('address').value
    }, function(results, status) {
      let resultRow = document.getElementById('result-row');
      if (status === 'OK' && results[0]) {
        resultRow.innerHTML = ""
        map = new google.maps.Map(target, {
          center: results[0].geometry.location,
          zoom: 15
        });

        // 座標の取得
        const latlng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
        console.log(results[0].geometry.location.lat(), results[0].geometry.location.lng())
        
        // 現在地から5kmの円を描く
        let circleOptions = {
          map: map,
          center: results[0].geometry.location,
          radius: 5000,
          strokeColor: '#bcddff',
          strokeOpacity: 1,
          strokeWeight: 1,
          fillColor: '#bcddff',
          fillOpacity: 0.35
        };
        circle = new google.maps.Circle(circleOptions);
      }

      // 現在地から5km以内のアクアショップを検索
      service = new google.maps.places.PlacesService(map);
      service.nearbySearch({
        location: new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng()),
        radius: 5000,
        type: ['pet_store'],
        keyword: ['熱帯魚', '淡水魚', '海水魚']
      }, function (results, status) {

        if (status === google.maps.places.PlacesServiceStatus.OK) {
          let resultCount = document.getElementById('result-count')

          for (let i = 0; i < results.length; i++) {
            // 地図上にマーカーを設置
            createMarker(results[i]);

            // マーカーをクリックした際の動作
            function createMarker(place) {
              let placeLoc = place.geometry.location;
              let marker = new google.maps.Marker({
                map: map,
                position: placeLoc
              });

              // ウィンドウの中身
              infoWindow = new google.maps.InfoWindow();
              google.maps.event.addListener(marker, 'click', function() {
                infoWindow.setContent(
                  '<div><strong>' + place.name +'<strong><br>' + '評価 ' + place.rating + '</div>' +
                  '<img class="shop-image" src=' + place.photos[0].getUrl({"maxWidth":300,"maxHeight":300}) + '>'
                );
                infoWindow.open(map, this);
              });
            }
            
            // 店舗詳細表示
            service.getDetails({
              placeId: results[i].place_id 
            }, function(place) {
              let setPhoto_1 = place.photos[0].getUrl({"maxWidth":200,"maxHeight":300});
              let setPhoto_2 = place.photos[1].getUrl({"maxWidth":200,"maxHeight":300});

              resultRow.insertAdjacentHTML('afterbegin',  
                `<div class='result-box col-lg-5 border shadow p-3 mb-5 bg-white rounded'>
                  <ul class='result-content'>
                    <li class='store_name text-primary border-bottom mb-2'>${place.name}</li>
                    <li class='store_address'>${place.formatted_address}</li>
                    <li>総合評価: <i class="fas fa-star text-warning"><span>${place.rating}</span></li>
                    <li>クチコミ件数: <span>${place.user_ratings_total}</span>件</li>
                  </ul>
                  <div class='shop-images'>
                    <a href="${place.website}" target="_blank" rel="noopener noreferrer">
                      <img src='${setPhoto_1}' class='shop-image me-1'>
                      <img src='${setPhoto_2}' class='shop-image'>
                    </a>
                  </div>
                </div>`
              );
            });
          }
        }
        
      }, function() {
        alert('Geolocation failed!');
        return;
      });
    });

  });

}
