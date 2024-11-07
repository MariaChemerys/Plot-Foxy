//
//  PlotSpaceNode Extensions.swift
//  Plot3d
//
//  Created by Mariia Chemerys on 07.11.2024.
//

import Foundation
import SceneKit

// Axis Nodes
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

// Arrow Nodes
extension PlotSpaceNode {
    func addPositiveArrowNode(arrowNode: SCNNode, axisNode: SCNNode, axisHeight: CGFloat) {
        if axisHeight > 0 {
            arrowNode.position = SCNVector3(0, axisHeight/2, 0)
            axisNode.addChildNode(arrowNode)
        }
    }
    
    func addNegativeArrowNode(arrowNode: SCNNode, axisNode: SCNNode, axisHeight: CGFloat) {
        if axisHeight > 0 {
            arrowNode.position = SCNVector3(0, -axisHeight/2, 0)
            axisNode.addChildNode(arrowNode)
        }
    }
}

// Rotations
extension PlotSpaceNode {
    func axisTextRotation(forAxis axis: PlotAxis) -> SCNVector3 {
        switch axis {
        case .x:
            return SCNVector3(-Double.pi/2, 0, 0)
        case .y:
           return SCNVector3(-Double.pi/2, 0, -Double.pi/2)
        case .z:
            return SCNVector3(-Double.pi/2, Double.pi/2, 0)
        }
    }
    
    func highlightRotation(forAxis axis: PlotAxis) -> SCNVector3 {
        switch axis {
        case .x:
            return SCNVector3(-Double.pi/2, 0, 0)
        case .y:
           return SCNVector3(0, 0, -Double.pi/2)
        case .z:
            return SCNVector3(0, 0, 0)
        }
    }
    
    func tickMarkTextRotation(forAxis axis: PlotAxis) -> SCNVector3 {
        switch axis {
        case .x:
            return SCNVector3(-Double.pi/2, 0, 0)
        case .y:
           return SCNVector3(-Double.pi/2, Double.pi/2, -Double.pi/2)
        case .z:
            return SCNVector3(-Double.pi/2, Double.pi/2, 0)
        }
    }
}
