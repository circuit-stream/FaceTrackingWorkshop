using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

public class MagicalFaceSwapper : MonoBehaviour
{
    private ARFaceManager faceManager;
    public List<Material> faceMaterials;
    private int faceMaterialIndex = 0;

    void Start()
    {
        faceManager = GetComponent<ARFaceManager>();
    }

    public void SwitchFaceMaterial()
    {
        foreach (ARFace face in faceManager.trackables)
        {
            face.GetComponent<MeshRenderer>().material = faceMaterials[faceMaterialIndex];
        }
        faceMaterialIndex++;

        if (faceMaterialIndex == faceMaterials.Count)
        {
            faceMaterialIndex = 0;
        }
    }
}
