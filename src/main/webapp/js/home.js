const API_BASE_URL = 'http://localhost:8282/api';

// Default placeholder image (base64 SVG - works offline)
const DEFAULT_IMAGE = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTUwIiBoZWlnaHQ9IjE1MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTUwIiBoZWlnaHQ9IjE1MCIgZmlsbD0iI2YwZjBmMCIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBmb250LWZhbWlseT0iQXJpYWwsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMTYiIGZpbGw9IiM5OTkiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj5Ib3RlbCBJbWFnZTwvdGV4dD48L3N2Zz4=';

// ============================================
// CHATBOT SESSION MANAGEMENT
// ============================================
var chatSessionId = null;  // Auto-managed session ID

// Chatbot send message function
function sendMessage() {
    var message = $('#chatInput').val();
    if (!message.trim()) return;
    
    // Display user message with bubble
    $('#chatMessages').append('<div class="chat-user-bubble"><strong>You:</strong> ' + message + '</div>');
    $('#chatInput').val('');
    
    // Show typing indicator
    $('#chatMessages').append('<div class="chat-bot-bubble" id="loading"><div class="chat-typing"><span></span><span></span><span></span></div></div>');
    $('#chatMessages').scrollTop($('#chatMessages')[0].scrollHeight);
    
    // Send to backend
    $.ajax({
        url: API_BASE_URL + '/chatbot/chat',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ 
            sessionId: chatSessionId,
            message: message 
        }),
        success: function(response) {
            $('#loading').remove();
            
            // Auto-save session ID
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

// Clear chatbot
function clearChatbot() {
    chatSessionId = null;
    $('#chatMessages').html('<div class="chat-bot-bubble"><strong>Bot:</strong> Hi! How can I help you find a hotel today?</div>');
}

// Toggle chatbot visibility
function toggleChatbot() {
    $('#chatbotCard').toggleClass('chatbot-minimize');
}

// ============================================
// HOTEL SEARCH & FILTER FUNCTIONALITY
// ============================================

$(document).ready(function() {
    console.log("Page loaded, initializing...");
    
    // Load all hotels on page load
    loadAllHotels();
    
    // Search button - uses improved search endpoint
    $('#searchBtn').click(function() {
        console.log("Search button clicked");
        searchHotelsWithType();
    });
    
    // Filter button - uses advanced filter endpoint
    $('#filterBtn').click(function() {
        console.log("Filter button clicked");
        applyAdvancedFilters();
    });
    
    // Clear button
    $('#clearBtn').click(function() {
        clearAllFilters();
        loadAllHotels();
    });
    
    // Allow Enter key in search box
    $('#searchLocation').keypress(function(e) {
        if (e.which === 13) {
            searchHotelsWithType();
        }
    });
    
    // Allow Enter key in chatbot
    $('#chatInput').keypress(function(e) {
        if (e.which === 13) {
            sendMessage();
        }
    });
    
    // Update placeholder when search type changes
    $('#searchType').change(function() {
        var searchType = $(this).val();
        var placeholder = '';
        
        switch(searchType) {
            case 'hotel':
                placeholder = 'Enter hotel name (e.g., Grand Plaza)...';
                break;
            case 'city':
                placeholder = 'Enter city name (e.g., New York)...';
                break;
            case 'state':
                placeholder = 'Enter state code (e.g., CA, NY)...';
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
    
    // Booking button
    $(document).on('click', '.btn-booking', function() {
        var hotelId = $(this).data('hotelid');
        var hotelName = $(this).data('hotelname');
        openBookingModal(hotelId, hotelName);
    });
    
    // Review button
    $(document).on('click', '.btn-review', function() {
        var hotelId = $(this).data('hotelid');
        loadReviews(hotelId);
    });
});

// Load all hotels
function loadAllHotels() {
    console.log("Loading all hotels...");
    
    $.ajax({
        url: API_BASE_URL + '/hotels',
        type: 'GET',
        success: function(hotels) {
            console.log("Loaded " + hotels.length + " hotels");
            displayHotels(hotels);
        },
        error: function(xhr, status, error) {
            console.error('Error loading hotels:', error);
            alert('Failed to load hotels. Make sure backend is running on port 8282.');
        }
    });
}

// Search hotels by type
function searchHotelsWithType() {
    var searchLocation = $('#searchLocation').val().trim();
    var searchType = $('#searchType').val();
    
    if (!searchLocation) {
        loadAllHotels();
        return;
    }
    
    console.log("Searching for: '" + searchLocation + "' by type: '" + searchType + "'");
    
    $.ajax({
        url: API_BASE_URL + '/hotels/search',
        type: 'GET',
        data: { 
            searchLocation: searchLocation,
            searchType: searchType
        },
        success: function(hotels) {
            console.log("Search returned " + hotels.length + " hotels");
            
            if (hotels.length === 0) {
                alert('No hotels found for "' + searchLocation + '" in ' + searchType);
            }
            
            displayHotels(hotels);
        },
        error: function(xhr, status, error) {
            console.error('Error searching hotels:', error);
            alert('Search failed. Please try again.');
        }
    });
}

// Advanced filtering with all criteria
function applyAdvancedFilters() {
    console.log("Applying advanced filters...");
    
    var searchLocation = $('#searchLocation').val().trim();
    var searchType = $('#searchType').val() || 'all';
    
    var selectedStarRatings = [];
    $('.star_rating:checked').each(function() {
        selectedStarRatings.push(parseInt($(this).val()));
    });
    
    var minPrice = $('#minPrice').val();
    var maxPrice = $('#maxPrice').val();
    
    var selectedAmenities = [];
    $('.hotel_amenity:checked').each(function() {
        selectedAmenities.push($(this).val());
    });
    
    var params = {};
    
    if (searchLocation) {
        params.searchLocation = searchLocation;
    }
    
    if (selectedStarRatings.length > 0) {
        params.minStarRating = Math.min(...selectedStarRatings);
        params.maxStarRating = Math.max(...selectedStarRatings);
    }
    
    if (minPrice) {
        params.minPrice = parseFloat(minPrice);
    }
    
    if (maxPrice) {
        params.maxPrice = parseFloat(maxPrice);
    }
    
    if (selectedAmenities.length > 0) {
        params.amenities = selectedAmenities;
    }
    
    console.log("Filter params:", params);
    
    if (Object.keys(params).length === 0) {
        loadAllHotels();
        return;
    }
    
    $.ajax({
        url: API_BASE_URL + '/hotels/filter',
        type: 'GET',
        data: params,
        traditional: true,
        success: function(hotels) {
            console.log("Filter returned " + hotels.length + " hotels");
            
            // Client-side filter by search type
            if (searchLocation && searchType !== 'all') {
                hotels = filterBySearchType(hotels, searchLocation, searchType);
            }
            
            if (hotels.length === 0) {
                alert('No hotels match your criteria.');
            }
            
            displayHotels(hotels);
        },
        error: function(xhr, status, error) {
            console.error('Error filtering:', error);
            alert('Filter failed.');
        }
    });
}

// Clear all filters
function clearAllFilters() {
    console.log("Clearing all filters");
    
    // Clear search box and type
    $('#searchLocation').val('');
    $('#searchType').val('all');
    $('#searchLocation').attr('placeholder', 'Enter search term...');
    
    // Uncheck all star ratings
    $('.star_rating').prop('checked', false);
    
    // Clear price range
    $('#minPrice').val('');
    $('#maxPrice').val('');
    
    // Uncheck all amenities
    $('.hotel_amenity').prop('checked', false);
}

// Generate star rating HTML
function generateStarRating(rating) {
    var stars = '';
    var fullStars = Math.floor(rating);
    var hasHalfStar = (rating % 1) >= 0.5;
    
    for (var i = 0; i < fullStars; i++) {
        stars += '<i class="fa fa-star" style="color: #ffa500;"></i>';
    }
    
    if (hasHalfStar && fullStars < 5) {
        stars += '<i class="fa fa-star-half-o" style="color: #ffa500;"></i>';
        fullStars++;
    }
    
    for (var i = fullStars; i < 5; i++) {
        stars += '<i class="fa fa-star-o" style="color: #ffa500;"></i>';
    }
    
    return stars;
}

// Filter hotels by search type
function filterBySearchType(hotels, searchTerm, searchType) {
    searchTerm = searchTerm.toLowerCase();
    
    return hotels.filter(function(hotel) {
        switch(searchType) {
            case 'state':
                return hotel.state && hotel.state.toLowerCase() === searchTerm;
            case 'city':
                return hotel.city && hotel.city.toLowerCase().includes(searchTerm);
            case 'hotel':
                return hotel.hotelName && hotel.hotelName.toLowerCase().includes(searchTerm);
            case 'address':
                return hotel.address && hotel.address.toLowerCase().includes(searchTerm);
            default:
                return true;
        }
    });
}

// Display hotels in table
function displayHotels(hotels) {
    console.log("Displaying " + hotels.length + " hotels");
    
    if ($('#htlTbl tbody').length === 0) {
        $('#htlTbl').append('<tbody></tbody>');
    }
    
    var tableBody = '';
    
    if (hotels.length === 0) {
        tableBody = '<tr><td colspan="9" style="text-align:center; padding: 20px;">No hotels found</td></tr>';
    } else {
        hotels.forEach(function(hotel) {
            var imageUrl = hotel.imageURL;
            if (!imageUrl || imageUrl.includes('placeholder.com')) {
                imageUrl = DEFAULT_IMAGE;
            }
            
            tableBody += '<tr>';
            
            // Hotel Name
            tableBody += '<td><strong>' + (hotel.hotelName || 'N/A') + '</strong></td>';
            
            // Image
            tableBody += '<td><img src="' + imageUrl + '" alt="' + hotel.hotelName + '" width="100" height="75" style="object-fit: cover; border-radius: 4px;" onerror="this.src=\'' + DEFAULT_IMAGE + '\';" /></td>';
            
            // Address
            tableBody += '<td>' + (hotel.address || 'N/A') + '</td>';
            
            // City
            tableBody += '<td>' + (hotel.city || 'N/A') + '</td>';
            
            // State
            tableBody += '<td>' + (hotel.state || 'N/A') + '</td>';
            
            // Star Rating
            var starRating = hotel.starRating || 0;
            tableBody += '<td>' + generateStarRating(starRating) + ' (' + starRating + ')</td>';
            
            // Average Price
            var avgPrice = hotel.averagePrice || 0;
            var discount = hotel.discount || 0;
            tableBody += '<td><span style="font-size: 18px; font-weight: bold; color: #28a745;">$' + avgPrice.toFixed(2) + '</span>';
            if (discount > 0) {
                tableBody += '<br><small style="color: #dc3545;">' + discount + '% off</small>';
            }
            tableBody += '</td>';
            
            // Times Booked
            var timesBooked = hotel.timesBooked || 0;
            tableBody += '<td><span class="badge badge-info">' + timesBooked + ' bookings</span></td>';
            
            // Actions
            tableBody += '<td>';
            tableBody += '<button class="btn btn-primary btn-sm btn-booking" data-hotelid="' + hotel.hotelId + '" data-hotelname="' + hotel.hotelName + '" style="margin-bottom: 5px;">Book Now</button><br>';
            tableBody += '<button class="btn btn-info btn-sm btn-review" data-hotelid="' + hotel.hotelId + '">View Reviews</button>';
            tableBody += '</td>';
            
            tableBody += '</tr>';
        });
    }
    
    $('#htlTbl tbody').html(tableBody);
    console.log("Table updated");
}

// Placeholder functions for modals (implement these as needed)
function openBookingModal(hotelId, hotelName) {
    console.log("Opening booking modal for hotel:", hotelName);
    // Your existing booking modal code here
    $('#myModal').modal('show');
    $('#modal_hotelId').val(hotelId);
    $('#modal_hotelName').val(hotelName);
}

function loadReviews(hotelId) {
    console.log("Loading reviews for hotel ID:", hotelId);
    // Your existing review loading code here
    $('#reviewModal').modal('show');
}
