using UnityEngine;
using System.Collections;

public class CameraMove : MonoBehaviour
{
    void Update ()
    {
        transform.localRotation = 
            Quaternion.AngleAxis (Time.time * 30.0f, Vector3.up) *
            Quaternion.AngleAxis (Mathf.Sin (Time.time * 0.37f) * 80.0f, Vector3.right);
    }
}