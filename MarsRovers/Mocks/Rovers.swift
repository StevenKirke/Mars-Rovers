//
//  Rovers.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import Foundation


var mockRovers: String = """
{
    "rovers": [
        {
            "id": 5,
            "name": "Curiosity",
            "landing_date": "2012-08-06",
            "launch_date": "2011-11-26",
            "status": "active",
            "max_sol": 3796,
            "max_date": "2023-04-11",
            "total_photos": 643337,
            "cameras": [
                {
                    "id": 20,
                    "name": "FHAZ",
                    "rover_id": 5,
                    "full_name": "Front Hazard Avoidance Camera"
                },
                {
                    "id": 26,
                    "name": "NAVCAM",
                    "rover_id": 5,
                    "full_name": "Navigation Camera"
                },
                {
                    "id": 22,
                    "name": "MAST",
                    "rover_id": 5,
                    "full_name": "Mast Camera"
                },
                {
                    "id": 23,
                    "name": "CHEMCAM",
                    "rover_id": 5,
                    "full_name": "Chemistry and Camera Complex"
                },
                {
                    "id": 24,
                    "name": "MAHLI",
                    "rover_id": 5,
                    "full_name": "Mars Hand Lens Imager"
                },
                {
                    "id": 25,
                    "name": "MARDI",
                    "rover_id": 5,
                    "full_name": "Mars Descent Imager"
                },
                {
                    "id": 21,
                    "name": "RHAZ",
                    "rover_id": 5,
                    "full_name": "Rear Hazard Avoidance Camera"
                }
            ]
        },
        {
            "id": 7,
            "name": "Spirit",
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete",
            "max_sol": 2208,
            "max_date": "2010-03-21",
            "total_photos": 124550,
            "cameras": [
                {
                    "id": 27,
                    "name": "FHAZ",
                    "rover_id": 7,
                    "full_name": "Front Hazard Avoidance Camera"
                },
                {
                    "id": 29,
                    "name": "NAVCAM",
                    "rover_id": 7,
                    "full_name": "Navigation Camera"
                },
                {
                    "id": 30,
                    "name": "PANCAM",
                    "rover_id": 7,
                    "full_name": "Panoramic Camera"
                },
                {
                    "id": 31,
                    "name": "MINITES",
                    "rover_id": 7,
                    "full_name": "Miniature Thermal Emission Spectrometer (Mini-TES)"
                },
                {
                    "id": 32,
                    "name": "ENTRY",
                    "rover_id": 7,
                    "full_name": "Entry, Descent, and Landing Camera"
                },
                {
                    "id": 28,
                    "name": "RHAZ",
                    "rover_id": 7,
                    "full_name": "Rear Hazard Avoidance Camera"
                }
            ]
        },
        {
            "id": 6,
            "name": "Opportunity",
            "landing_date": "2004-01-25",
            "launch_date": "2003-07-07",
            "status": "complete",
            "max_sol": 5111,
            "max_date": "2018-06-11",
            "total_photos": 198439,
            "cameras": [
                {
                    "id": 14,
                    "name": "FHAZ",
                    "rover_id": 6,
                    "full_name": "Front Hazard Avoidance Camera"
                },
                {
                    "id": 16,
                    "name": "NAVCAM",
                    "rover_id": 6,
                    "full_name": "Navigation Camera"
                },
                {
                    "id": 17,
                    "name": "PANCAM",
                    "rover_id": 6,
                    "full_name": "Panoramic Camera"
                },
                {
                    "id": 18,
                    "name": "MINITES",
                    "rover_id": 6,
                    "full_name": "Miniature Thermal Emission Spectrometer (Mini-TES)"
                },
                {
                    "id": 19,
                    "name": "ENTRY",
                    "rover_id": 6,
                    "full_name": "Entry, Descent, and Landing Camera"
                },
                {
                    "id": 15,
                    "name": "RHAZ",
                    "rover_id": 6,
                    "full_name": "Rear Hazard Avoidance Camera"
                }
            ]
        },
        {
            "id": 8,
            "name": "Perseverance",
            "landing_date": "2021-02-18",
            "launch_date": "2020-07-30",
            "status": "active",
            "max_sol": 761,
            "max_date": "2023-04-10",
            "total_photos": 147898,
            "cameras": [
                {
                    "id": 33,
                    "name": "EDL_RUCAM",
                    "rover_id": 8,
                    "full_name": "Rover Up-Look Camera"
                },
                {
                    "id": 35,
                    "name": "EDL_DDCAM",
                    "rover_id": 8,
                    "full_name": "Descent Stage Down-Look Camera"
                },
                {
                    "id": 36,
                    "name": "EDL_PUCAM1",
                    "rover_id": 8,
                    "full_name": "Parachute Up-Look Camera A"
                },
                {
                    "id": 37,
                    "name": "EDL_PUCAM2",
                    "rover_id": 8,
                    "full_name": "Parachute Up-Look Camera B"
                },
                {
                    "id": 38,
                    "name": "NAVCAM_LEFT",
                    "rover_id": 8,
                    "full_name": "Navigation Camera - Left"
                },
                {
                    "id": 39,
                    "name": "NAVCAM_RIGHT",
                    "rover_id": 8,
                    "full_name": "Navigation Camera - Right"
                },
                {
                    "id": 40,
                    "name": "MCZ_RIGHT",
                    "rover_id": 8,
                    "full_name": "Mast Camera Zoom - Right"
                },
                {
                    "id": 41,
                    "name": "MCZ_LEFT",
                    "rover_id": 8,
                    "full_name": "Mast Camera Zoom - Left"
                },
                {
                    "id": 42,
                    "name": "FRONT_HAZCAM_LEFT_A",
                    "rover_id": 8,
                    "full_name": "Front Hazard Avoidance Camera - Left"
                },
                {
                    "id": 43,
                    "name": "FRONT_HAZCAM_RIGHT_A",
                    "rover_id": 8,
                    "full_name": "Front Hazard Avoidance Camera - Right"
                },
                {
                    "id": 44,
                    "name": "REAR_HAZCAM_LEFT",
                    "rover_id": 8,
                    "full_name": "Rear Hazard Avoidance Camera - Left"
                },
                {
                    "id": 45,
                    "name": "REAR_HAZCAM_RIGHT",
                    "rover_id": 8,
                    "full_name": "Rear Hazard Avoidance Camera - Right"
                },
                {
                    "id": 34,
                    "name": "EDL_RDCAM",
                    "rover_id": 8,
                    "full_name": "Rover Down-Look Camera"
                },
                {
                    "id": 46,
                    "name": "SKYCAM",
                    "rover_id": 8,
                    "full_name": "MEDA Skycam"
                },
                {
                    "id": 47,
                    "name": "SHERLOC_WATSON",
                    "rover_id": 8,
                    "full_name": "SHERLOC WATSON Camera"
                },
                {
                    "id": 48,
                    "name": "SUPERCAM_RMI",
                    "rover_id": 8,
                    "full_name": "SuperCam Remote Micro Imager"
                },
                {
                    "id": 49,
                    "name": "LCAM",
                    "rover_id": 8,
                    "full_name": "Lander Vision System Camera"
                }
            ]
        }
    ]
}
"""
