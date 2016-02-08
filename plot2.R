# plot2.R. This script will perform the following:
# 1  Download Elecric Power Consumption dataset. There are a number of scripts required for this
#    submission - all are required to perform this step
# 2. Read data for dates 2007-02-01 and 2007-02-02.
# 3. Rename columns as per assignment
# 4. Generate Plot 2: Global Active Power Plot diagram
# 5. Create output file plot2.png

# Note: this script assumes that Working Directory is already set appropriately

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Dataset.zip",method="internal")
unzip(zipfile="./Dataset.zip",exdir=".")


# Set the file to read
datafile <- file("./household_power_consumption.txt", "r");

# Read in the data for dates as specified
DT <- read.table(text = grep("^[1,2]/2/2007", readLines(datafile), value = TRUE), 
                  sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# Set columns as per descriptions of variables in assignment
names(DT) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage",
               "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

# Add a new date+time column
DT$date_time <- as.POSIXct(paste(DT$date, DT$time), format = "%d/%m/%Y %T")

# Generate Plot 2: Global Active Power Plot Diagram
par(mfrow = c(1, 1))
plot(DT$date_time, 
  DT$global_active_power, 
  type="l", 
  xlab="", 
  ylab="Global Active Power (kilowatts)"
)
# Create PNG file
dev.copy(png, file = "plot2.png")

# Close PNG file
dev.off()