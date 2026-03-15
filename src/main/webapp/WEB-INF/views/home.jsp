<!DOCTYPE html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page of Travel Gig</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page isELIgnored="false" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="frm" %>
<!DOCTYPE html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page of Travel Gig</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src='./js/home.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
/* Enhanced Chatbot Styles */
.chat-user-bubble {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 10px 14px;
    border-radius: 18px;
    border-bottom-right-radius: 4px;
    max-width: 80%;
    word-wrap: break-word;
    margin-left: auto;
    margin-bottom: 10px;
}

.chat-bot-bubble {
    background: #f1f3f5;
    color: #1f2937;
    padding: 10px 14px;
    border-radius: 18px;
    border-bottom-left-radius: 4px;
    max-width: 80%;
    word-wrap: break-word;
    margin-right: auto;
    margin-bottom: 10px;
}

.chat-typing {
    display: inline-flex;
    gap: 4px;
    padding: 10px 14px;
}

.chat-typing span {
    width: 8px;
    height: 8px;
    background: #667eea;
    border-radius: 50%;
    animation: bounce 1.4s infinite;
}

.chat-typing span:nth-child(2) {
    animation-delay: 0.2s;
}

.chat-typing span:nth-child(3) {
    animation-delay: 0.4s;
}

@keyframes bounce {
    0%, 80%, 100% {
        transform: scale(0.8);
        opacity: 0.5;
    }
    40% {
        transform: scale(1.2);
        opacity: 1;
    }
}

/* Minimized chatbot state */
.chatbot-minimized .card-body,
.chatbot-minimized .card-footer {
    display: none !important;
}

.chatbot-minimized {
    height: auto !important;
}

.chatbot-minimized .card-header {
    cursor: pointer;
}
</style>
</head>
<body>

<div class="container" style="margin-left:100px">
	<h1>Welcome to Travel Gig</h1>
	<h2>Search your desired hotel</h2>
</div>

<div class="container border rounded" style="margin:auto;padding:30px;margin-top:50px;margin-bottom:50px;background-color:#f8f9fa;">
	<h3 style="margin-bottom: 25px;"><i class="fa fa-search"></i> Narrow your search results</h3>
	
	<div class="form-row align-items-end">
		<!-- Search Type Dropdown -->
		<div class="form-group col-md-2">
			<label for="searchType" style="font-weight: 600;">Search By:</label>
			<select class="form-control" id="searchType" name="searchType">
				<option value="all">All Fields</option>
				<option value="hotel">Hotel Name</option>
				<option value="city">City</option>
				<option value="state">State</option>
				<option value="address">Address</option>
			</select>
		</div>
		
		<!-- Search Input -->
		<div class="form-group col-md-3">
			<label for="searchLocation" style="font-weight: 600;">Search:</label>
			<input class="form-control" type="text" id="searchLocation" name="searchLocation" placeholder="Enter search term..."/>
		</div>
		
		<!-- Number of Rooms -->
		<div class="form-group col-md-1">
			<label for="noRooms" style="font-weight: 600;">Rooms:</label>
			<input class="form-control" type="number" id="noRooms" name="noRooms" min="1" placeholder="1"/>
		</div>
		
		<!-- Number of Guests -->
		<div class="form-group col-md-1">
			<label for="noGuests" style="font-weight: 600;">Guests:</label>
			<input class="form-control" type="number" id="noGuests" name="noGuests" min="1" placeholder="1"/>
		</div>
		
		<!-- Check-In Date -->
		<div class="form-group col-md-2">
			<label for="checkInDate" style="font-weight: 600;">Check-In:</label>
			<input class="form-control" type="date" id="checkInDate" name="checkInDate"/>
		</div>
		
		<!-- Check-Out Date -->
		<div class="form-group col-md-2">
			<label for="checkOutDate" style="font-weight: 600;">Check-Out:</label>
			<input class="form-control" type="date" id="checkOutDate" name="checkOutDate"/>
		</div>
		
		<!-- Search Button -->
		<div class="form-group col-md-1">
			<button class="btn btn-primary btn-block" type="button" id="searchBtn" style="height: 38px;">
				<i class="fa fa-search"></i> SEARCH
			</button>
		</div>
	</div>
</div>

<div class="row">
	<!-- IMPROVED SIDEBAR - Expanded from col-2 to col-3 -->
	<div class="col-3 border rounded" style="margin-left:50px;padding:25px">
		<h4 style="text-align:center; margin-bottom: 20px;">
			<i class="fa fa-filter"></i> Search & Filter
		</h4>
		
		<!-- Star Rating Filter -->
		<div class="form-group">
			<label><i class="fa fa-star"></i> Star Rating</label>
			<div class="form-check">
				<input class="form-check-input star_rating" type="checkbox" value="5" id="star5">
				<label class="form-check-label" for="star5">5 Stars ⭐⭐⭐⭐⭐</label>
			</div>
			<div class="form-check">
				<input class="form-check-input star_rating" type="checkbox" value="4" id="star4">
				<label class="form-check-label" for="star4">4 Stars ⭐⭐⭐⭐</label>
			</div>
			<div class="form-check">
				<input class="form-check-input star_rating" type="checkbox" value="3" id="star3">
				<label class="form-check-label" for="star3">3 Stars ⭐⭐⭐</label>
			</div>
			<div class="form-check">
				<input class="form-check-input star_rating" type="checkbox" value="2" id="star2">
				<label class="form-check-label" for="star2">2 Stars ⭐⭐</label>
			</div>
		</div>
		
		<hr>
		
		<!-- Price Range Filter -->
		<div class="form-group">
			<label for="minPrice"><i class="fa fa-dollar"></i> Price Range</label>
			<div class="row">
				<div class="col-6">
					<input type="number" class="form-control form-control-sm" 
						   id="minPrice" placeholder="Min $" min="0">
				</div>
				<div class="col-6">
					<input type="number" class="form-control form-control-sm" 
						   id="maxPrice" placeholder="Max $" min="0">
				</div>
			</div>
			<small class="form-text text-muted">Enter price range per night</small>
		</div>
		
		<!-- EXPANDED AMENITIES -->
		<div class="form-group">
			<label><i class="fa fa-check-square"></i> Amenities</label>
			
			<!-- Essential -->
			<div style="margin-bottom: 10px;">
				<strong style="font-size: 12px; color: #666;">Essential</strong>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="WIFI" id="amenWifi">
				<label class="form-check-label" for="amenWifi">
					<i class="fa fa-wifi"></i> WiFi
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="PARKING" id="amenParking">
				<label class="form-check-label" for="amenParking">
					<i class="fa fa-car"></i> Parking
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="BREAKFAST" id="amenBreakfast">
				<label class="form-check-label" for="amenBreakfast">
					<i class="fa fa-coffee"></i> Breakfast
				</label>
			</div>
			
			<!-- Facilities -->
			<div style="margin-top: 10px; margin-bottom: 10px;">
				<strong style="font-size: 12px; color: #666;">Facilities</strong>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="POOL" id="amenPool">
				<label class="form-check-label" for="amenPool">
					<i class="fa fa-tint"></i> Swimming Pool
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="FITNESS CENTER" id="amenGym">
				<label class="form-check-label" for="amenGym">
					<i class="fa fa-heartbeat"></i> Fitness Center
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="SPA" id="amenSpa">
				<label class="form-check-label" for="amenSpa">
					<i class="fa fa-leaf"></i> Spa
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="RESTAURANT" id="amenRestaurant">
				<label class="form-check-label" for="amenRestaurant">
					<i class="fa fa-cutlery"></i> Restaurant
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="BAR OR LOUNGE" id="amenBar">
				<label class="form-check-label" for="amenBar">
					<i class="fa fa-glass"></i> Bar/Lounge
				</label>
			</div>
			
			<!-- Business & Services -->
			<div style="margin-top: 10px; margin-bottom: 10px;">
				<strong style="font-size: 12px; color: #666;">Business & Services</strong>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="BUSINESS CENTER" id="amenBusiness">
				<label class="form-check-label" for="amenBusiness">
					<i class="fa fa-briefcase"></i> Business Center
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="MEETING ROOMS" id="amenMeeting">
				<label class="form-check-label" for="amenMeeting">
					<i class="fa fa-users"></i> Meeting Rooms
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="ROOM SERVICE" id="amenRoom">
				<label class="form-check-label" for="amenRoom">
					<i class="fa fa-bell"></i> Room Service
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="CONCIERGE" id="amenConcierge">
				<label class="form-check-label" for="amenConcierge">
					<i class="fa fa-user"></i> Concierge
				</label>
			</div>
			
			<!-- Transportation -->
			<div style="margin-top: 10px; margin-bottom: 10px;">
				<strong style="font-size: 12px; color: #666;">Transportation</strong>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="AIRPORT SHUTTLE" id="amenShuttle">
				<label class="form-check-label" for="amenShuttle">
					<i class="fa fa-plane"></i> Airport Shuttle
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="VALET PARKING" id="amenValet">
				<label class="form-check-label" for="amenValet">
					<i class="fa fa-key"></i> Valet Parking
				</label>
			</div>
			
			<!-- Family & Accessibility -->
			<div style="margin-top: 10px; margin-bottom: 10px;">
				<strong style="font-size: 12px; color: #666;">Family & Accessibility</strong>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="PET FRIENDLY" id="amenPets">
				<label class="form-check-label" for="amenPets">
					<i class="fa fa-paw"></i> Pet Friendly
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="ACCESSIBLE" id="amenAccessible">
				<label class="form-check-label" for="amenAccessible">
					<i class="fa fa-wheelchair"></i> Wheelchair Accessible
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input hotel_amenity" type="checkbox" value="KIDS CLUB" id="amenKids">
				<label class="form-check-label" for="amenKids">
					<i class="fa fa-child"></i> Kids Club
				</label>
			</div>
		</div>
		
		<hr>
		
		<!-- Filter Buttons -->
		<button id="filterBtn" class="btn btn-success btn-block" style="margin-bottom: 10px;">
			<i class="fa fa-filter"></i> Apply Filters
		</button>
		
		<button id="clearBtn" class="btn btn-secondary btn-block">
			<i class="fa fa-refresh"></i> Clear All
		</button>
	</div>

	<!-- MAIN CONTENT AREA - Changed from col-7 to col-8 to accommodate wider sidebar -->
	<div class="col-8 border rounded" style="margin-left:50px; padding: 20px;">
		<div style='text-align:center;font-size:24px;font-family:"Trebuchet MS", Helvetica, sans-serif; margin-bottom: 20px;'>
			<i class="fa fa-hotel"></i> Available Hotels
		</div>	
		
		<div id="listHotel" style="overflow-x: auto;">
			<table id='htlTbl' class="table table-striped table-hover" style="width: 100%;">
				<thead class="thead-dark">
					<tr>
						<th>Hotel Name</th>
						<th>Image</th>
						<th>Address</th>
						<th>City</th>
						<th>State</th>
						<th>Star Rating</th>
						<th>Avg Price</th>
						<th>Bookings</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<!-- Hotels will be populated here by JavaScript -->
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- All your existing modals stay the same -->
<!-- BOOKING MODAL -->
<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Search Hotel Rooms</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">        
				<div class="col">
					<input class="form-control" type="hidden" id="modal_hotelId"/>
					Hotel Name: <input readonly="true" class="form-control" type="text" id="modal_hotelName"/>
					<input type='hidden' id='hiddenHotelId'/>
					No. Guests: <input class="form-control" type="number" id="modal_noGuests"/>
					Check-In Date: <input class="form-control" type="date" id="modal_checkInDate"/>
					Check-Out Date: <input class="form-control" type="date" id="modal_checkOutDate"/>
					Room Type: 
					<select class="form-control" id="select_roomTypes">
					</select>
					No. Rooms: <input class="form-control" type="number" id="modal_noRooms"/>
					<input style="margin-top:25px" class="btn btn-searchHotelRooms form-control btn-primary" type="button" id="guestSearch" value="SEARCH"/>       	
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- REVIEW MODAL -->
<div class="modal" id="reviewModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"><i class="fa fa-star"></i> Hotel Reviews & Ratings</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">        
				<!-- Reviews will be populated here by JavaScript -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- GUEST MODAL -->
<div class="modal" id="guestModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Guest Details</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">        
				<div class="col" id='guestInnerDiv'>        	     	
					<input type='hidden' id='hidHotelId'/>
					<input type='hidden' id='hidNoRooms'/>
					<input type='hidden' id='hidCheckInDate'/>
					<input type='hidden' id='hidCheckOutDate'/>
					<input type='hidden' id='hidRoomType'/>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id='bookingBtn'>Book</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- HOTEL ROOMS MODAL -->
<div class="modal" id="hotelRoomsModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Are these details correct?</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body" id="hotelRooms_modalBody">        
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- BOOKING CONFIRMATION MODAL -->
<div class="modal" id="bookingHotelRoomModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"></h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body" id="bookingRoom_modalBody">        
				<div class="col">
					<div><input class="form-control" type="hidden" id="booking_hotelId"/></div>
					<div><input class="form-control" type="hidden" id="booking_hotelRoomId"/></div>
					<div>Hotel Name: <input readonly="true" class="form-control" type="text" id="booking_hotelName"/></div>
					<div>Customer Mobile: <input class="form-control" type="text" id="booking_customerMobile"/></div>
					<div id="noGuestsDiv">No. Guests: <input readonly="true" class="form-control" type="number" id="booking_noGuests"/></div>
					<div>No. Rooms: <input readonly="true" class="form-control" type="number" id="booking_noRooms"/></div>
					<div>Check-In Date: <input readonly="true" class="form-control" type="text" id="booking_checkInDate"/></div>
					<div>Check-Out Date: <input readonly="true" class="form-control" type="text" id="booking_checkOutDate"/></div>
					<div>Room Type: <input readonly="true" class="form-control" type="text" id="booking_roomType"/></div>
					<div>Discount: $<span id="booking_discount"></span></div>
					<div>Total Price: $<span id="booking_price"></span></div>       			
					<div style='margin-top:20px'>
						<button class='btn-confirm-booking btn btn-primary'>Confirm Booking</button>
						<button class='btn btn-primary'>Edit</button>
					</div>
				</div>          
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- ENHANCED CHATBOT OVERLAY (Bottom-Right) -->
<div id="chatbotCard" class="card shadow-lg" style="position: fixed; bottom: 20px; right: 20px; width: 380px; z-index: 1000; border-radius: 12px; border: none;">
	<div class="card-header text-white d-flex justify-content-between align-items-center" onclick="toggleChatbot()" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 12px 12px 0 0; cursor: pointer;">
		<span><i class="fa fa-comments"></i> <strong>Hotel Assistant</strong></span>
		<div onclick="event.stopPropagation();">
			<button class="btn btn-sm text-white" onclick="clearChatbot()" title="Clear chat" style="background: rgba(255,255,255,0.2); border: none; padding: 4px 8px;">
				<i class="fa fa-trash"></i>
			</button>
			<button class="btn btn-sm text-white" onclick="toggleChatbot()" title="Minimize/Maximize" style="background: rgba(255,255,255,0.2); border: none; padding: 4px 8px;">
				<i class="fa fa-minus" id="chatbot-toggle-icon"></i>
			</button>
		</div>
	</div>
	<div class="card-body" style="height: 450px; overflow-y: auto; background: #f9fafb;" id="chatMessages">
		<div class="chat-bot-bubble">
			<strong>Bot:</strong> Hi! How can I help you find a hotel today?
		</div>
	</div>
	<div class="card-footer" style="border-radius: 0 0 12px 12px; background: white; border-top: 1px solid #e5e7eb;">
		<div class="input-group">
			<input type="text" class="form-control" id="chatInput" placeholder="Ask me anything..." style="border-radius: 20px; border: 2px solid #e5e7eb;">
			<div class="input-group-append" style="margin-left: 8px;">
				<button class="btn btn-primary" onclick="sendMessage()" style="border-radius: 20px; padding: 6px 16px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none;">
					<i class="fa fa-paper-plane"></i>
				</button>
			</div>
		</div>
	</div>
</div>

<script>
var chatSessionId = null;

function sendMessage() {
	var message = $('#chatInput').val();
	if (!message.trim()) return;
	
	$('#chatMessages').append('<div class="chat-user-bubble"><strong>You:</strong> ' + message + '</div>');
	$('#chatInput').val('');
	
	$('#chatMessages').append('<div class="chat-bot-bubble" id="loading"><div class="chat-typing"><span></span><span></span><span></span></div></div>');
	$('#chatMessages').scrollTop($('#chatMessages')[0].scrollHeight);
	
	$.ajax({
		url: 'http://localhost:8282/api/chatbot/chat',
	    type: 'POST',
	    contentType: 'application/json',
	    data: JSON.stringify({ 
	    	sessionId: chatSessionId,
	        message: message 
	    }),
	    success: function(response) {
	        $('#loading').remove();
	        
	        if (response.sessionId) {
	        	chatSessionId = response.sessionId;
	        }
	        
	        $('#chatMessages').append('<div class="chat-bot-bubble"><strong>Bot:</strong> ' + response.botResponse + '</div>');
	        $('#chatMessages').scrollTop($('#chatMessages')[0].scrollHeight);
	    },
	    error: function(error) {
	        $('#loading').remove();
	        $('#chatMessages').append('<div class="chat-bot-bubble text-danger"><strong>Error:</strong> Failed to get response</div>');
	    }
	});
}

function clearChatbot() {
	chatSessionId = null;
	$('#chatMessages').html('<div class="chat-bot-bubble"><strong>Bot:</strong> Hi! How can I help you find a hotel today?</div>');
}

function toggleChatbot() {
	$('#chatbotCard').toggleClass('chatbot-minimized');
	
	// Toggle icon between minus and plus
	if ($('#chatbotCard').hasClass('chatbot-minimized')) {
		$('#chatbot-toggle-icon').removeClass('fa-minus').addClass('fa-plus');
	} else {
		$('#chatbot-toggle-icon').removeClass('fa-plus').addClass('fa-minus');
	}
}

$('#chatInput').keypress(function(e) {
	if (e.which === 13) {
		sendMessage();
	}
});
</script>

<script>
$(document).ready(function() {
	$('#searchType').change(function() {
		var searchType = $(this).val();
		var placeholder = '';
		
		switch(searchType) {
			case 'hotel':
				placeholder = 'Enter hotel name...';
				break;
			case 'city':
				placeholder = 'Enter city name...';
				break;
			case 'state':
				placeholder = 'Enter state (e.g., CA, NY)...';
				break;
			case 'address':
				placeholder = 'Enter address...';
				break;
			case 'all':
			default:
				placeholder = 'Enter search term...';
				break;
		}
		
		$('#searchLocation').attr('placeholder', placeholder);
	});
});
</script>
</body>
</html>
