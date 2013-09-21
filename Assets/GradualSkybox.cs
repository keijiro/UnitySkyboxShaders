using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class GradualSkybox : MonoBehaviour
{
    public Material targetMaterial;
    public Color topColor;
    public Color bottomColor;
 
    void Update ()
    {
        if (targetMaterial != null) {
            RenderSettings.skybox = targetMaterial;
            targetMaterial.SetVector ("_UpVector", transform.up);
            targetMaterial.SetColor ("_Color1", bottomColor);
            targetMaterial.SetColor ("_Color2", topColor);
        }
    }
}