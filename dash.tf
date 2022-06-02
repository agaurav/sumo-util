resource "sumologic_dashboard" "tf_SLO_CloudCollector_Ingest_Lag" {
    title            = "SLO-CloudCollector Ingest Lag"
    description      = "Tracks 95 objective: Track number of seconds a message is delayed in the ingest pipeline"
    refresh_interval = "300"
    theme            = "Light"

    

    time_range {
        begin_bounded_time_range {
            from {
                literal_time_range {
                    range_name = "today"
                }
                
            }
        }
        
    }
    


    topology_label_map {
        
        data {
            label  = "service"
            values = [
                 "cloudcollector" 
            ]
        }
        
    }


    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "gauge-today"
            title           = "Today's Availability"
            description     = "#good-requests / #requests since start of day"
            # stacked time series
            visual_settings = jsonencode(
                {"general":{"displayType":"default","mode":"singleValueMetrics","type":"svp"},"series":{},"svp":{"gauge":{"show":true},"hideData":false,"hideLabel":false,"label":"Availability (%)","labelFontSize":14,"noDataString":"No data","option":"Average","rounding":2,"sparkline":{"show":false},"thresholds":[{"color":"#bf2121","from":0,"to":95},{"color":"#DFBE2E","from":95,"to":97.5},{"color":"#16943e","from":97.5,"to":100.1}],"useBackgroundColor":false,"useNoData":false,"valueFontSize":24},"title":{"fontSize":14}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{cluster}}"="*" or cluster="{{cluster}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| order by _timeslice asc
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne
| sum(sliceHealthy) as healthySlices, sum(timesliceOne) as totalSlices
| (healthySlices/totalSlices)*100 as Availability
| fields Availability


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        literal_time_range {
                            range_name = "today"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "gauge-week"
            title           = "Week's Availability"
            description     = "#good-requests / #requests since start of week"
            # stacked time series
            visual_settings = jsonencode(
                {"general":{"displayType":"default","mode":"singleValueMetrics","type":"svp"},"series":{},"svp":{"gauge":{"show":true},"hideData":false,"hideLabel":false,"label":"Availability (%)","labelFontSize":14,"noDataString":"No data","option":"Average","rounding":2,"sparkline":{"show":false},"thresholds":[{"color":"#bf2121","from":0,"to":95},{"color":"#DFBE2E","from":95,"to":97.5},{"color":"#16943e","from":97.5,"to":100.1}],"useBackgroundColor":false,"useNoData":false,"valueFontSize":24},"title":{"fontSize":14}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{cluster}}"="*" or cluster="{{cluster}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| order by _timeslice asc
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne
| sum(sliceHealthy) as healthySlices, sum(timesliceOne) as totalSlices
| (healthySlices/totalSlices)*100 as Availability
| fields Availability


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        literal_time_range {
                            range_name = "week"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "gauge-month"
            title           = "Month's Availability"
            description     = "#good-requests / #requests since start of month"
            # stacked time series
            visual_settings = jsonencode(
                {"general":{"displayType":"default","mode":"singleValueMetrics","type":"svp"},"series":{},"svp":{"gauge":{"show":true},"hideData":false,"hideLabel":false,"label":"Availability (%)","labelFontSize":14,"noDataString":"No data","option":"Average","rounding":2,"sparkline":{"show":false},"thresholds":[{"color":"#bf2121","from":0,"to":95},{"color":"#DFBE2E","from":95,"to":97.5},{"color":"#16943e","from":97.5,"to":100.1}],"useBackgroundColor":false,"useNoData":false,"valueFontSize":24},"title":{"fontSize":14}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{cluster}}"="*" or cluster="{{cluster}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| order by _timeslice asc
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne
| sum(sliceHealthy) as healthySlices, sum(timesliceOne) as totalSlices
| (healthySlices/totalSlices)*100 as Availability
| fields Availability


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        literal_time_range {
                            range_name = "month"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "hourly-burn-rate"
            title           = "Hourly Burn Rate"
            description     = "(ErrorsObserved)/(ErrorBudget) for the hour buckets where ErrorBudget = (1-SLO)*TotalRequests"
            # stacked time series
            visual_settings = jsonencode(
                {"axes":{"axisX":{"title":""},"axisY":{"title":"hourlyBurnRate","unit":{"isCustom":false,"value":"%"}}},"color":{"family":"Diverging 2"},"general":{"displayType":"default","fillOpacity":1,"mode":"timeSeries","type":"column"},"overrides":[{"properties":{"color":"#7959b3","fillOpacity":0.8,"name":"today"},"queries":[],"series":["hourlyBurnRate"]},{"properties":{"color":"#4ea0bc","fillOpacity":0.7,"name":"today-24h"},"queries":[],"series":["hourlyBurnRate_1d"]}],"series":{},"title":{"fontSize":14}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{cluster}}"="*" or cluster="{{cluster}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne | _timeslice as _messagetime 
| timeslice 60m 
| sum(sliceHealthy) as healthySlices, sum(timesliceOne) as totalSlices by _timeslice
| order by _timeslice asc
| ((1 - healthySlices/totalSlices)/(1-0.95)) as hourlyBurnRate
| fields _timeslice, hourlyBurnRate | compare timeshift 1d


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        relative_time_range {
                            relative_time = "-1d"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "burn-trend"
            title           = "Burn rate trend compared to last 7 days  (upto current time of the day)"
            description     = "Today's burn rate (so far) along with last 7 days (till the same time as today)"
            # stacked time series
            visual_settings = jsonencode(
                {"general":{"displayType":"default","mode":"honeyComb","type":"honeyComb"},"honeyComb":{"aggregationType":"avg","groupBy":[],"shape":"hexagon","thresholds":[{"color":"#16943e","from":0,"to":50},{"color":"#ebc034","from":50,"to":200},{"color":"#c40e20","from":200,"to":10000}]},"series":{},"title":{"fontSize":14}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{cluster}}"="*" or cluster="{{cluster}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne
| sum(sliceHealthy) as totalGood, sum(timesliceOne) as totalCount 
| ((1 - totalGood/totalCount)/(1-0.95))*100 as BurnRate | fields BurnRate | compare timeshift 1d 7 
| fields BurnRate_7d,BurnRate_6d,BurnRate_5d,BurnRate_4d,BurnRate_3d,BurnRate_2d,BurnRate_1d,BurnRate


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        literal_time_range {
                            range_name = "today"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "budget-left"
            title           = "Budget remaining"
            description     = "Error budget from start of month"
            # stacked time series
            visual_settings = jsonencode(
                {"axes":{"axisX":{"labelFontSize":12,"title":"","titleFontSize":12},"axisY":{"labelFontSize":12,"logarithmic":false,"title":"","titleFontSize":12,"unit":{"isCustom":false,"value":"%"}}},"color":{"family":"Categorical Default"},"general":{"displayType":"default","lineDashType":"solid","lineThickness":1,"markerSize":5,"markerType":"none","mode":"timeSeries","type":"line"},"legend":{"enabled":true,"fontSize":12,"maxHeight":50,"showAsTable":false,"verticalAlign":"bottom","wrap":true},"overrides":[{"properties":{"color":"#50caf2","lineDashType":"dash","lineThickness":1.5,"name":"Forecasted Budget Remaining","type":"line"},"queries":[],"series":["budgetRemaining_predicted"]},{"properties":{"color":"#f7995b","lineThickness":0,"name":"Budget Remaining","type":"area"},"queries":[],"series":["budgetRemaining"]}],"series":{},"title":{"fontSize":14}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{cluster}}"="*" or cluster="{{cluster}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| (timesliceGoodCount/timesliceTotalCount)  as timesliceRatio
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne | _timeslice as _messagetime 
| timeslice 60m 
| sum(sliceHealthy) as healthySlices, sum(timesliceOne) as totalSlices by _timeslice
| healthySlices/totalSlices as tmSLO 
| (totalSlices - healthySlices) as tmBad 
| order by _timeslice asc
| accum tmBad as runningBad  
| toLong(formatDate(now(), "M")) as monthIndex
| if(monthIndex == 12,0,1) as addToMonth 
| parseDate(format("2021-%d-01",toLong(monthIndex)), "yyyy-MM-dd") as ym
| parseDate(format("2021-%d-01",toLong(monthIndex+addToMonth)), "yyyy-MM-dd") as ymNext
| toLong(if(monthIndex == 12,31,(ymNext - ym)/(24*3600*1000))) as dayCount
| (dayCount*24*60)*(1-0.95) as errorBudget
| (1-runningBad/errorBudget) as budgetRemaining 
| fields _timeslice, budgetRemaining
| predict budgetRemaining by 1h model=ar, forecast=800
| toLong(formatDate(_timeslice, "M")) as tmIndex 
| toLong(formatDate(now(), "M")) as monthIndex
| where  tmIndex = monthIndex | if(isNull(budgetRemaining),budgetRemaining_predicted,budgetRemaining) as budgetRemaining_predicted 
| fields _timeslice,budgetRemaining, budgetRemaining_predicted 


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        literal_time_range {
                            range_name = "month"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    panel {
        sumo_search_panel {
            key             = "breakdown"
            title           = "SLO Breakdown"
            description     = "reliability stats by fields specified in the config"
            # stacked time series
            visual_settings = jsonencode(
                {"axes":{"axisX":{"labelFontSize":12,"titleFontSize":12},"axisY":{"labelFontSize":12,"titleFontSize":12}},"general":{"decimals":2,"displayType":"default","fontSize":16,"mode":"distribution","paginationPageSize":100,"type":"table"},"legend":{"enabled":false},"series":{},"title":{"fontSize":24}}
            )
            keep_visual_settings_consistent_with_parent = true

            query {
                query_string = <<QUERY
_view=slogen_tf_cloudcollector_cc_ingest_lag_v2 | where ("{{cluster}}"="*" or cluster="{{cluster}}") and ("{{customerID}}"="*" or customerID="{{customerID}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") 
| timeslice 1m 
| sum(sliceGoodCount) as timesliceGoodCount, sum(sliceTotalCount) as timesliceTotalCount by _timeslice , customerID,deployment,cluster  
| fillmissing timeslice(1m)
| if(timesliceTotalCount ==0, 1,(timesliceGoodCount/timesliceTotalCount))  as timesliceRatio
| (timesliceGoodCount/timesliceTotalCount)  as timesliceRatio
| if(timesliceRatio >= 0.9, 1,0) as sliceHealthy
| 1 as timesliceOne | _timeslice as _messagetime 
| sum(sliceHealthy) as healthySlices, sum(timesliceOne) as totalSlices by customerID,deployment,cluster  
| (healthySlices/totalSlices)*100 as Availability_Percentage
| (totalSlices - healthySlices) as badSlices
| toLong(formatDate(now(), "M")) as monthIndex
| if(monthIndex == 12,0,1) as addToMonth 
| parseDate(format("2021-%d-01",toLong(monthIndex)), "yyyy-MM-dd") as ym
| parseDate(format("2021-%d-01",toLong(monthIndex+addToMonth)), "yyyy-MM-dd") as ymNext
| toLong(if(monthIndex == 12,31,(ymNext - ym)/(24*3600*1000))) as dayCount
| (dayCount*24*60)*(1-0.95) as errorBudget
| (1-badSlices/errorBudget) as BudgetRemaining 
| (BudgetRemaining)*errorBudget as DowntimeRemainingInMinutes 
| DowntimeRemainingInMinutes/60 as DowntimeRemainingInHours 
| DowntimeRemainingInMinutes%60 as DowntimeRemainingMinuteModulo 
| format("%2.0fh%2.0fm",DowntimeRemainingInHours,DowntimeRemainingMinuteModulo) as %"Budget Remaining (Time)"
| BudgetRemaining*100 as %"Budget Remaining (%)"
| order by BudgetRemaining asc
| Availability_Percentage as %"Availability (%)" 
| fields  customerID,deployment,cluster,  %"Availability (%)", %"Budget Remaining (%)", %"Budget Remaining (Time)"


QUERY
                query_type   = "Logs"
                query_key    = "A"
//                add metric query support

            }

            
            time_range {
                begin_bounded_time_range {
                    from {
                        literal_time_range {
                            range_name = "month"
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    ## search panel - log query
    
    
    ## search panel - log query
    
    

    ## layout
    layout {
        grid {
            
            layout_structure {
                key       = "gauge-today"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":0}"
            }
            
            layout_structure {
                key       = "gauge-week"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":6}"
            }
            
            layout_structure {
                key       = "gauge-month"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":12}"
            }
            
            layout_structure {
                key       = "hourly-burn-rate"
                structure = "{\"height\":6,\"width\":18,\"x\":6,\"y\":0}"
            }
            
            layout_structure {
                key       = "burn-trend"
                structure = "{\"height\":6,\"width\":18,\"x\":6,\"y\":6}"
            }
            
            layout_structure {
                key       = "budget-left"
                structure = "{\"height\":6,\"width\":18,\"x\":6,\"y\":12}"
            }
            
            layout_structure {
                key       = "text-panel-config"
                structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":18}"
            }
            
            layout_structure {
                key       = "text-panel-details"
                structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":18}"
            }
            
            layout_structure {
                key       = "breakdown"
                structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":24}"
            }
            
        }
    }

    

    variable {
        name          = "deployment"
        display_name  = "deployment"
        default_value = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf_cloudcollector_cc_ingest_lag_v2"
                field = "deployment"
            }
        }
        allow_multi_select = "true"
        include_all_option = "true"
        hide_from_ui       = "false"
    }
    

    variable {
        name          = "cluster"
        display_name  = "cluster"
        default_value = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf_cloudcollector_cc_ingest_lag_v2"
                field = "cluster"
            }
        }
        allow_multi_select = "true"
        include_all_option = "true"
        hide_from_ui       = "false"
    }
    

    variable {
        name          = "customerID"
        display_name  = "customerID"
        default_value = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf_cloudcollector_cc_ingest_lag_v2"
                field = "customerID"
            }
        }
        allow_multi_select = "true"
        include_all_option = "true"
        hide_from_ui       = "false"
    }
    
}
