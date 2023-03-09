Boston Fisheries Management system

Team Information:
Course Name : Database Management and Database Design Course Code : INFO6210-36462
Professor Name : Naveen Kuragayala
Team Number : 9
Project Topic : Fisheries Management System 
Team Members :
* Saivignesh Sridhar
* Vignesh Haribalakrishnan
* Vishal Narasimhan

Business problems:
* Exploitation by over-fishing and unethical means of fishing has taken a huge toll on
fishing industry and being a spoiler to biodiversity of water body.
*  As there is a rising demand for fish and seafood, the fishing industry has been overfishing in increasingly larger of water body.
*  Over-fishing occurs when fish populations are reduced to below dangerously low
levels, resulting in reduced growth, resource depletion, and sometimes unsustainable
population sizes.
*  This practice has been linked to the ruin of several ecosystems as well as reduced
catches for many fishing companies.
* It is also estimated to cause huge financial loss for fishing teams around the world
annually due over-fishing and subpar management practices.

Business problems addressed:
* Equal business opportunity is created for every fishing teams. By regulating various
activities in the spawning areas to provide equal chances to the fishing members with a
less catches.
* A system for enforcing the rule and implementing strategy and tool to monitor the
result. And captured data is used to improve the current practices.
* Impact on biodiversity of water body is observed so that further deterioration can be
stopped and situationally alternate method to improve eco-system is implemented.
( Healthy fish population is maintained by continuous monitoring of fish growth cycles
and captures made by fisherman. 

DATABASE ACCESS RESTRICTIONS:
* Admin will have full access to all the table.
* Management staff will have read/write access
for slots, Location, sub location, bookings, fisherman and read access for remaining table.
* Fisher men will have only read access for fisherman details, Fish
stats, location.
* On-prem biologist will have read and edit access to loc stats table, read access to Fish stats, fish species tables.

BUSINESS RULES:
1. Every Fisherman is a member and the details are recorded in fisherman entity.
2. Each Fisherman can make only one booking in one day and it is recorded in bookings entity.
3. Each booking refers to a particular slot referring to Forenoon (FN) or Afternoon (AN) shift in
a particular sub location.
4. There are currently three locations where the organization has installed their facility. Their
details are available in location entity.
5. Each location has multiple sublocations so that the fishermen can be equally spaced to
provide equal opportunities to all the members who have booked. They are available in
sub_location.
6. Fish species available in a particular location are recorded in fish_species entity and the
population of every recorded species is preserved by maintaining a threshold value beyond 
which fishing at that particular sub location is prohibited. These things are recorded in
fish_stats entity.
7. The biologist researchs the biological and environmental details of the installed locations
and records it in loc_stats entity, which the help of which some essential factors like total
fish quantity, etc.
8. The booking status remains pending until the fisherman confirms their attendance to the
organization. If the attendance is not confirmed until an hour before the slot time, it gets
cancelled automatically and will be available for others to book.
9. Each fisherman who has made a booking has to check in on time. There can be multiple
check ins for a particular booking id but every check in has to have its corresponding check
out by the end of the slot. These details are recorded in checkin_log and checkout_log.
10. Check in officers have to record if the fisherman is carrying appropriate Personal Protective
Equipment and if they have taken Covid test within 72 hours. These details are again recorded in checkin_log.
