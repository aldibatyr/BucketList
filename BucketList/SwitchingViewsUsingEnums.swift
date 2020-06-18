//
//  SwitchingViewsUsingEnums.swift
//  BucketList
//
//  Created by Aldiyar B on 6/17/20.
//  Copyright © 2020 Aldiyar B. All rights reserved.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed")
    }
}

struct SwitchingViewsUsingEnums: View {
    
    var loadingState = LoadingState.loading
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct SwitchingViewsUsingEnums_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingViewsUsingEnums()
    }
}
