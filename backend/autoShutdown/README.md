# Auto Shutdown

## Overview

This directory contains the files used to create a GCP Cloud Function which halts spending past the indicated limit on a GCP project.

This is currently implemented for both the `evac-drill-console` and `evacuation-drill-app-osu` projects.

This file will also describe the configuration steps taken to implement this automated stop.

## Data Safety Note

The current approach taken to protecting ourselves from excess spending is destructive. That is to say, it revokes the billing account from the project, which means that none of the infrastructure within that project will be maintained. It should be assumed that if this eventuality is reached, all data stored within the GCP project (current drill plans and results) will be lost.

This is a last-ditch effort. There will be several email notifications sent to admin prior to this eventuality, which should prompt either an expansion of the budget limit or a clamping down on misbehaving components of the project.

## Configuration

### APIs

Several GCP APIs need to be enabled within the project:

1. Cloud Billing API
1. Cloud Build
1. Cloud Functions

### Service Account

A new service account needs to be created for the Cloud Function which is able to remove the billing account from the project to halt spending.

To enable the service account to do this, we will grant it the roles "Project>Viewer" and "Project Billing Manager"

### Budget

To track whether the current spending is in excess of the desired spending, we need to define a new budget which only applies to the project in question. This budget should have alert thresholds at *and* beyond the threshold at which we intend to halt spending.

The budget also allows us to configure email notifications for admin personel, via the Cloud Monitoring API.

We will need to create and connect a new Pub/Sub Topic to this budget to ensure that the Cloud Function can receive the alert threshold notifications as well.

### Pub/Sub Topic

The new Pub/Sub topic needs to be created and linked to the budget.

### Cloud Function

The Cloud Function should be triggered by the Pub/Sub topic previously created and connected to the budget. It should have a reasonable maximum number of instances (we chose 4 initially), and should use the service account which was previously granted the necessary permissions for the desired action.

The code for the Cloud Function can be found within this directory in `index.js` and `package.json`.
