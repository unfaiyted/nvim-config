# hello test 


flowchart TB
    subgraph "VPS Deployment"
        direction TB
        FRONTEND["Frontend Process\n- React Application\n- User Interface"]
        SERVER["Backend Server Process\n- Main API Endpoints\n- Business Logic"]
        RECC_MANAGER["Recc Manager Process\n- Recommendation Engine\n- Report Generation"]
        INDY_FETCHER["Indy Transaction Fetcher\n- Blockchain Transaction Retrieval\n- Data Synchronization"]
    end

    subgraph "Recc Reports Workflow"
        TRPC_ROUTER["tRPC Router\n- alertNeedsRecalc Endpoint\n- specificFullReport Endpoint"]
        REPORT_BUILDER["Report Builder\n- buildServerRecReports\n- Generate Recommendation Reports"]
        REPORT_CACHE["Report Cache\n- updateReportInCache\n- Store & Manage Reports"]
    end

    subgraph "Data Sources"
        PLAID_DATA["Plaid Financial Data"]
        BLOCKCHAIN_TXN["Blockchain Transactions"]
    end

    FRONTEND <-->|API Calls| SERVER
    SERVER <-->|Trigger Recalc| RECC_MANAGER
    RECC_MANAGER <-->|tRPC Endpoints| TRPC_ROUTER
    TRPC_ROUTER <-->|Build Reports| REPORT_BUILDER
    REPORT_BUILDER -->|Cache Reports| REPORT_CACHE
    
    INDY_FETCHER -->|Sync Data| SERVER
    
    PLAID_DATA -->|Financial Inputs| REPORT_BUILDER
    BLOCKCHAIN_TXN -->|Transaction Data| INDY_FETCHER
