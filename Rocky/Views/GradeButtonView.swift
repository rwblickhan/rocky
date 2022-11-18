//
//  GradeButtonView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct GradeButtonView: View {
    private let grade: Grade
    
    init(_ grade: Grade) {
        self.grade = grade
    }
    
    var body: some View {
        Text(grade.displayName)
    }
}

struct GradeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GradeButtonView(.v0)
    }
}
