//
//  PlotSpaceNode Extensions.swift
//  Plot3d
//
//  Created by Mariia Chemerys on 07.11.2024.
//

import Foundation
import SceneKit

extension PlotSpaceNode {
    func addPositiveAxisNode(axisNode: SCNNode, axisHeight: CGFloat, axis: PlotAxis) {
        switch axis {
        case .x:
            axisNode.position = SCNVector3(axisHeight/2, 0, 0)
            axisNode.eulerAngles = SCNVector3(0, 0, -Double.pi/2)
        case .y:
            axisNode.position = SCNVector3(0, axisHeight/2, 0)
        case .z:
            axisNode.position = SCNVector3(0, 0, axisHeight/2)
            axisNode.eulerAngles = SCNVector3(Double.pi/2, 0, 0)
        }
        addChildNode(axisNode)
    }
    
    func addNegativeAxisNode(axisNode: SCNNode, axisHeight: CGFloat, axis: PlotAxis) {
        switch axis {
        case .x:
            axisNode.position = SCNVector3(-axisHeight/2, 0, 0)
            axisNode.eulerAngles = SCNVector3(0, 0, -Double.pi/2)
        case .y:
            axisNode.position = SCNVector3(0, -axisHeight/2, 0)
        case .z:
            axisNode.position = SCNVector3(0, 0, -axisHeight/2)
            axisNode.eulerAngles = SCNVector3(Double.pi/2, 0, 0)
        }
        addChildNode(axisNode)
    }
}
